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
                let next = HomeViewController(nibName: nil, bundle: nil)
                self.navigationController?.pushViewController(next, animated: false)
        })
    }
}
