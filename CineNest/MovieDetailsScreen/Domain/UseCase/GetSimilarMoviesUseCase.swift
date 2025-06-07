//
//  GetSimilarMoviesUseCase.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation
import RxSwift

protocol GetSimilarMoviesUsecaseContract {
    func execute(movieID: Int) -> Observable<[Movie]>
}

struct GetSimilarMoviesUsecase: GetSimilarMoviesUsecaseContract {
    
    private let repository: MovieDetailsRepositoryContract
    init(repository: MovieDetailsRepositoryContract) {
        self.repository = repository
    }
    
    func execute(movieID: Int) -> Observable<[Movie]> {
        return repository.fetchSimilarMovies(movieID: movieID)
    }
}

