//
//  TargetType.swift
//  CineNest
//
//  Created by Peter on 05/06/2025.
//

import Foundation
import Alamofire

enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ParametersType {
    case requestPlain
    case requestParameters(parameters:[String:Any],encoding: ParameterEncoding )
}

protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethodType { get }
    var headers: [String: String]? { get }
    /// override this to append more headers
    var customHeaders: [String: String]? { get }
    var parameters: ParametersType? { get }
}
extension TargetType {
    var baseURL: String {
        Constants.APIConstatnts.baseURL
    }
}
// MARK: - Provides a Default Headers
/// with allowing the option to customize
extension TargetType {
    var headers: [String: String]? {
        NetworkHeaders.commonHeaders.merging(customHeaders ?? [:]) { _, new in new }
    }
    /// provides a nil custom headers by default
    var customHeaders: [String: String]? { return nil }
}

enum NetworkHeaders {
    static var commonHeaders: [String: String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": Bundle.main.TMDBKey
        ]
    }
}
