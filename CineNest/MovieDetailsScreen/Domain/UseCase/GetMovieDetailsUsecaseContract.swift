//
//  GetMovieDetailsUsecaseContract.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation
import RxSwift

protocol GetMovieDetailsUsecaseContract {
    func execute(movieID: Int) -> Observable<MovieDetailsModel>
}

struct GetMovieDetailsUsecase: GetMovieDetailsUsecaseContract {
    
    private let repository: MovieDetailsRepositoryContract
    init(repository: MovieDetailsRepositoryContract) {
        self.repository = repository
    }
    
    func execute(movieID: Int) -> Observable<MovieDetailsModel> {
        return repository.fetchMovieDetails(movieID: movieID)
    }
}

