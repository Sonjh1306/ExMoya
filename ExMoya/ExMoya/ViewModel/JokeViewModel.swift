import Foundation
import Moya
import RxSwift
import RxCocoa

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    var disposeBag: DisposeBag { get set }
}

final class JokeViewModel: ViewModelProtocol {
    
    struct Input {
        let refreshJokeData = PublishSubject<Void>()
    }
    
    struct Output {
        let jokeData = PublishRelay<Joke>()
        let errorAlert = PublishRelay<String>()
        let loadgingState = PublishRelay<Bool>()
    }
    
    var input: Input = Input()
    var output: Output = Output()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init() {
        input.refreshJokeData
            .flatMap{ _ in self.fetchJokeData()}
            .catch({ (error) in
                switch error as! NetworkError {
                case .notConnection: self.output.errorAlert.accept("Not Connection")
                case .noData: self.output.errorAlert.accept("No Data")
                case .failDecode: self.output.errorAlert.accept("Fail Decode")
                case .notValidateStatusCode: self.output.errorAlert.accept("Not Validate StatusCode")
                }
                return Observable.just(Joke(iconURL: "", id: "", updatedAt: "", url: "", value: ""))
            })
                .subscribe { [weak self] (result) in
                self?.output.jokeData.accept(result)
            }.disposed(by: disposeBag)
    }
    
    func fetchJokeData() -> Observable<Joke> {
        return Observable.create { [weak self] (observer) in
            self?.output.loadgingState.accept(true)
            
            JokeAPI.executeFetchJokeData { succeed, failed in
                if failed != nil {
                    observer.onError(failed!)
                }
                if let succeed = succeed {
                    observer.onNext(succeed)
                }
                self?.output.loadgingState.accept(false)
                observer.onCompleted()
            }
            return Disposables.create()
        }
        
    }
}
