//
//  MoviesDetailsConfigurator.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation

final class MoviesDetailsConfigurator {
    static func build(movieID: Int) -> MoviesDetailsViewController {
        let remoteDataSource = MovieDetailsRemoteDataSource()
        let repo = MovieDetailsRepository(remoteDataSource: remoteDataSource)
        let getMoviesDetailsUseCase = GetMovieDetailsUsecase(repository: repo)
        let similarMoviesUseCase = GetSimilarMoviesUsecase(repository: repo)
        let viewModel = MoviesDetailsViewModel(
            getMovieDetailsUsecase: getMoviesDetailsUseCase,
            getSimilarMoviesUseCase: similarMoviesUseCase,
            movieID: movieID
        )
        return MoviesDetailsViewController(viewModel: viewModel)
    }
    
}
