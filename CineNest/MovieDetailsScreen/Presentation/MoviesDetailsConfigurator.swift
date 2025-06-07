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
        let castGroupingService = CastGroupingService()
        let getMoviesDetailsUseCase = GetMovieDetailsUsecase(repository: repo)
        let similarMoviesUseCase = GetSimilarMoviesUsecase(repository: repo)
        let getCastUseCase = GetCastUseCase(
            repository: repo,
            CastGroupingServiceContract: castGroupingService
        )
        let wishListDataSource = MovieWishListLocalDataSource()
        let wishListRepository = WishListRepository(wishListDataSource: wishListDataSource)
        let wishListUseCase = GetWishListUsecase(repository: wishListRepository)
        let viewModel = MoviesDetailsViewModel(
            getMovieDetailsUsecase: getMoviesDetailsUseCase,
            getSimilarMoviesUseCase: similarMoviesUseCase,
            getCastUseCase: getCastUseCase,
            wishListUseCase: wishListUseCase,
            movieID: movieID
        )
        return MoviesDetailsViewController(viewModel: viewModel)
    }
    
}
