//
//  BaseTargetType.swift
//  ExMoya
//
//  Created by sonjuhyeong on 2023/02/09.
//

import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.chucknorris.io")!
    }
    
    var path: String {
        return "/jokes/random"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
