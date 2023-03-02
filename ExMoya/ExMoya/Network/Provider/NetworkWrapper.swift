//
//  NetworkWrapper.swift
//  ExMoya
//
//  Created by sonjuhyeong on 2023/03/02.
//

import Moya

class NetworkWrapper<Provider: TargetType>: MoyaProvider<Provider> {
    
    init(endPointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
         plugins: [PluginType]) {
        
        let session = MoyaProvider<Provider>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 30
        session.sessionConfiguration.timeoutIntervalForResource = 30
        
        super.init(endpointClosure: endPointClosure, stubClosure: stubClosure, session: session, plugins: plugins)
    }
    
    func sendRequest<Model: Codable>(provider: Provider,
                                     decodingType: Model.Type,
                                     completion: @escaping(Result<Model, NetworkError>) -> Void) {
        self.request(provider) { result in
            switch result {
            case .success(let response):
                if (200..<300).contains(response.statusCode) {
                    do {
                        let decodeData = try JSONDecoder().decode(Model.self, from:response.data)
                        completion(.success(decodeData))
                    } catch {
                        completion(.failure(.failDecode))
                    }
                    completion(.failure(.noData))
                } else {
                    completion(.failure(.notValidateStatusCode))
                }
            case .failure(_):
                completion(.failure(.notConnection))
            }
            
        }
    }
    
}

