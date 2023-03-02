//
//  JokeAPI.swift
//  ExMoya
//
//  Created by sonjuhyeong on 2023/02/09.
//

import Moya

struct JokeAPI {
    
    static let wrapper = NetworkWrapper<JokeTarget>(plugins: [NetworkLoggerPlugin()])
    
    static func executeFetchJokeData(completion: @escaping (_ succeed: Joke?, _ failed: NetworkError?) -> Void) {
        wrapper.sendRequest(provider: .getJoke, decodingType: Joke.self) { result in
            switch result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
