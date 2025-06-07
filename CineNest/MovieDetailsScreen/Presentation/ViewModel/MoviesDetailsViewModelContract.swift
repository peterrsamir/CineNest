//
//  MoviesDetailsViewModelContract.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation
import RxRelay

protocol MoviesDetailsViewModelContract: BaseViewModelContract {
    var movieDetailsModel: BehaviorRelay<MovieDetailsModel?> { get set }
    var similarMovies: BehaviorRelay<[Movie]> { get set }
}
