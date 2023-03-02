//
//  NetworkError.swift
//  ExMoya
//
//  Created by sonjuhyeong on 2023/03/02.
//

import Foundation

enum NetworkError: Error {
    case notConnection
    case notValidateStatusCode
    case noData
    case failDecode
}
