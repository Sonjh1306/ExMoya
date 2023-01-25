import UIKit
import SnapKit
import Moya
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
 
    let viewModel = JokeViewModel()
    let jokeView = JokeView()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = jokeView
        bind()
    }
    
    func bind() {
        
        // Action -> Input
        viewModel.input.refreshJokeData.onNext(())
        
        jokeView.changeButton.rx.tap
            .asObservable()
            .bind(to: self.viewModel.input.refreshJokeData)
            .disposed(by: disposeBag)
            
        
        // Output -> Update
        // Fetch Joke Data
        viewModel.output.jokeData
            .bind { [weak self] (joke) in
                self?.jokeView.configureJokeData(joke: joke)
            }.disposed(by: disposeBag)
        
        // Error 생성 시 Alert Popup
        viewModel.output.errorAlert
            .subscribe(on: MainScheduler.asyncInstance)
            .bind { [weak self] (alertMessage) in
                self?.alert(message: alertMessage)
            }.disposed(by: disposeBag)
        
        // Loding 시 Indicator Animating
        viewModel.output.loadgingState
            .distinctUntilChanged()
            .bind(to: self.jokeView.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // Loading 시 버튼 Enabled
        viewModel.output.loadgingState
            .distinctUntilChanged()
            .map{ !$0 }
            .bind(to: self.jokeView.changeButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
  
}

extension UIViewController {
    func alert(title : String = "알림", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
