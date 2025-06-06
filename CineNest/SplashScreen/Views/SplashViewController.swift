//
//  SplashViewController.swift
//  CineNest
//
//  Created by Peter on 04/06/2025.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NavigateToHomeScreen()
    }

    func NavigateToHomeScreen() {
        DispatchQueue.main.asyncAfter(
            deadline: .now()+2,
            execute: {
                let homeDataSource = HomeRemoteDataSource()
                let repo = HomeRepository(remoteDataSource: homeDataSource)
                let usecase = HomeUseCase(repository: repo)
                let viewmodel = HomeViewModel(useCase: usecase)
                let next = HomeViewController(viewModel: viewmodel)
                self.navigationController?.pushViewController(next, animated: false)
        })
    }
}
