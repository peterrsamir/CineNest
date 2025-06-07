//
//  HomeModuleConfigurator.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import Foundation

final class HomeModuleConfigurator {
    static func build() -> HomeViewController{
        let homeDataSource = HomeRemoteDataSource()
        let repo = HomeRepository(remoteDataSource: homeDataSource)
        let getMoviesuseCase = GetMoviesUseCase(repository: repo)
        let searchMoviesUseCase = SearchMoviesUseCase(repository: repo)
        let wishListDataSource = MovieWishListLocalDataSource()
        let wishListRepository = WishListRepository(wishListDataSource: wishListDataSource)
        let wishListUseCase = GetWishListUsecase(repository: wishListRepository)
        let viewmodel = HomeViewModel(
            getMoviesUseCase: getMoviesuseCase,
            searchMoviesUseCase: searchMoviesUseCase,
            wishListUseCase: wishListUseCase
        )
        let homeViewController = HomeViewController(viewModel: viewmodel)
        return homeViewController
    }
}
