//
//  HomeUseCase.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import RxSwift

protocol GetMoviesUseCaseContract {
    func execute(page: Int) -> Observable<[Movie]>
}

struct GetMoviesUseCase: GetMoviesUseCaseContract {
    
    private let repository: HomeRepositoryContract
    
    init(repository: HomeRepositoryContract) {
        self.repository = repository
    }
    
    func execute(page: Int) -> Observable<[Movie]> {
        return repository.fetchMovies(page: page)
            .map { movies in
                let grouped = movies.groupedByYear()
                return grouped.flatMap { $0.movies }
            }
    }
}
