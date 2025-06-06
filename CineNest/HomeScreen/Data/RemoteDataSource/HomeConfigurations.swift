//
//  HomeConfigurations.swift
//  CineNest
//
//  Created by Peter on 05/06/2025.
//

import Foundation
import Alamofire

enum HomeConfigurations {
    case getMovies(page: String)
    case searchMovies(page: String, query: String?)
}

extension HomeConfigurations: TargetType {
    
    var path: String {
        switch self {
        case .getMovies:
            Constants.APIConstatnts.popularMoviesUrlPath
        case .searchMovies:
            Constants.APIConstatnts.searchMoviesUrlPath
        }
    }
    var method: HTTPMethodType {
        .get
    }
    var parameters: ParametersType? {
        switch self {
        case .getMovies(page: let page):
            let params: [String: Any] = [
                Constants.APIConstatnts.includeAdults: false,
                Constants.APIConstatnts.includeVideo: false,
                Constants.APIConstatnts.page: page,
                Constants.APIConstatnts.sortBy: Constants.APIConstatnts.popularityDesc
            ]
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.default
            )
        case .searchMovies(page: let page, query: let query):
            return .requestParameters(
                parameters:
                    [Constants.APIConstatnts.includeAdults: false,
                     Constants.APIConstatnts.includeVideo: false,
                     Constants.APIConstatnts.page: page,
                     Constants.APIConstatnts.sortBy: Constants.APIConstatnts.popularityDesc,
                     Constants.APIConstatnts.query: query ?? ""
                    ],
                encoding: URLEncoding.default)
        }
    }
}
