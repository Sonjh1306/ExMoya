import Foundation
import Moya

enum JokeTarget {
    case getJoke
}

extension JokeTarget: BaseTargetType {
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}
