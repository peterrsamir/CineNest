//
//  ApiConstants.swift
//  CineNest
//
//  Created by Peter on 05/06/2025.
//

import Foundation
enum Constants{
    enum APIConstatnts {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let popularMoviesUrlPath = "movie/popular"
        static let searchMoviesUrlPath = "search/movie"
        static let includeAdults = "include_adult"
        static let includeVideo = "include_video"
        static let page = "page"
        static let sortBy = "sort_by"
        static let query = "query"
        static let popularityDesc = "popularity.desc"
        static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
        static let moviesDetailsUrlPath = "movie/%d"
        static let similarMoviesUrlPath = "movie/%d/similar"
        static let similarMovieCastUrlPath = "movie/%d/credits"
    }
    
}

extension Notification.Name {
    static let wishListUpdated = Notification.Name("wishListUpdated")
}
