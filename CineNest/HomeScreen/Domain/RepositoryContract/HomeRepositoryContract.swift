//
//  HomeRepositoryContract.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import RxSwift

protocol HomeRepositoryContract {
    func fetchMovies(page: Int) -> Observable<[Movie]>
    func fetchSearchedMovies(page: Int, query: String?) -> Observable<[Movie]>
}
