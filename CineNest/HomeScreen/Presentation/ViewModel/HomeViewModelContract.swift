//
//  HomeViewModelContract.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import Foundation
import RxRelay
import RxSwift

protocol HomeViewModelContract {
    var items: BehaviorRelay<[Movie]> {get set}
    func fetchMovies(page: Int) -> Observable<[Movie]>
    func getMappedCellModelFromMovie(movie: Movie) -> MoviesCellModel
}
