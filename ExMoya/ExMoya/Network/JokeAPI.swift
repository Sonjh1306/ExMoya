//
//  JokeAPI.swift
//  ExMoya
//
//  Created by sonjuhyeong on 2023/02/09.
//

import Moya

struct JokeAPI: Networkable {
    
    typealias Target = JokeTarget
    
    /// page에 해당하는 User 정보 조회
    static func getUserList(completion: @escaping (_ succeed: Joke?, _ failed: Error?) -> Void) {
        makeProvider().request(.getJoke) { result in
            switch ResponseData<Joke>.processJSONResponse(result) {
            case .success(let model): return completion(model, nil)
            case .failure(let error): return completion(nil, error)
            }
        }
    }
}
