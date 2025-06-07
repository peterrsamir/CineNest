//
//  MovieDetailsRepositoryContract.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation
import RxSwift

protocol MovieDetailsRepositoryContract {
    func fetchMovieDetails(movieID: Int) -> Observable<MovieDetailsModel>
    func fetchSimilarMovies(movieID: Int) -> Observable<[Movie]>
    func fetchCastFromSimilarMovies(movieID: Int) -> Observable<[MovieCastModel]>
}
