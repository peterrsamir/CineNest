//
//  MovieDetailsConfigurations.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation
import Alamofire

enum MovieDetailsConfigurations {
    case getMovieDetailsBy(id: Int)
    case getSimilarMovies(id: Int)
    case getCastFromSimilarMoviesBy(id: Int)
}

extension MovieDetailsConfigurations: TargetType {
    
    var path: String {
        switch self {
        case .getMovieDetailsBy(let id):
            return String(format: Constants.APIConstatnts.moviesDetailsUrlPath, id)
        case .getSimilarMovies(let id):
            return String(format: Constants.APIConstatnts.similarMoviesUrlPath, id)
        case .getCastFromSimilarMoviesBy(let id):
            return String(format: Constants.APIConstatnts.similarMovieCastUrlPath, id)
        }
    }
    var method: HTTPMethodType {
        .get
    }
    var parameters: ParametersType? {
        switch self {
        case .getMovieDetailsBy:
            return .requestPlain
            
        case .getSimilarMovies:
            return .requestPlain
            
        case .getCastFromSimilarMoviesBy:
            return .requestPlain
        }
    }
}

