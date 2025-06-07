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
    var groupedCastItems: BehaviorRelay<[CastingSection]> { get set }
    var hasCasting: BehaviorRelay<Bool> { get set }
    var isWishListed: Bool { get set }
    func toggleWishList()
}
