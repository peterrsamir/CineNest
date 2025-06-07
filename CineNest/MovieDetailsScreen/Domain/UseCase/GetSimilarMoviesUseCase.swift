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
    
    
    /// - Parameter movieID: get Similar Movies with ID
    /// - Returns: return the first 5 as business needs
    func execute(movieID: Int) -> Observable<[Movie]> {
        return repository.fetchSimilarMovies(movieID: movieID)
            .map({ Array($0.prefix(5)) })
    }
}

