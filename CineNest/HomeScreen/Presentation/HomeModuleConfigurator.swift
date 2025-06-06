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
        let usecase = HomeUseCase(repository: repo)
        let viewmodel = HomeViewModel(useCase: usecase)
        let homeViewController = HomeViewController(viewModel: viewmodel)
        return homeViewController
    }
}
