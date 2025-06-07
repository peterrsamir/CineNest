//
//  HomeViewModelContract.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import Foundation
import RxRelay
import RxSwift

protocol HomeViewModelContract: BaseViewModelContract {
    var moviesGroupedByYear: BehaviorRelay<[Movie]> {get set}
    var searchedMovies: BehaviorRelay<[Movie]> {get set}
    func fetchMovies(page: Int)
    func getMappedCellModelFromMovie(movie: Movie) -> MoviesCellModel
    func searchMovies(page: Int, query: String?)
    func loadNextPageIfNeeded(currentIndex: Int, query: String?)
    func isMovieWishListed(movieID: String) -> Bool
}
