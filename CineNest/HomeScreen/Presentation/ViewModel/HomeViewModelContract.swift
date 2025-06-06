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
    var itemsGroupedByYear: BehaviorRelay<[Movie]> {get set}
    func fetchMovies(page: Int) 
    func getMappedCellModelFromMovie(movie: Movie) -> MoviesCellModel
    func loadNextPageIfNeeded(currentIndex: Int)
}
