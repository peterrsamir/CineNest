//
//  SearchMoviesUseCase.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import Foundation
import RxSwift

protocol SearchMoviesUseCaseContract {
    func execute(page: Int, query: String?) -> Observable<[Movie]>
}

struct SearchMoviesUseCase: SearchMoviesUseCaseContract {
    
    private let repository: HomeRepositoryContract
    init(repository: HomeRepositoryContract) {
        self.repository = repository
    }
    
    func execute(page: Int, query: String?) -> Observable<[Movie]> {
        return repository.fetchSearchedMovies(page: page, query: query)
            .map { movies in
                let grouped = movies.groupedByYear()
                return grouped.flatMap { $0.movies }
            }
    }
}
