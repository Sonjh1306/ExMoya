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

enum NetworkError: Error {
    case networkError
    case decodingError
    case urlError
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
                case .networkError:
                    self.output.errorAlert.accept("Network Error")
                case .decodingError:
                    self.output.errorAlert.accept("Decoding Error")
                case .urlError:
                    self.output.errorAlert.accept("URL Error")
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
            
            JokeAPI.getUserList { response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let response = response else { return }
                observer.onNext(response)
                observer.onCompleted()
                self?.output.loadgingState.accept(false)
            }
            return Disposables.create()
        }
        
    }
    
    
}
