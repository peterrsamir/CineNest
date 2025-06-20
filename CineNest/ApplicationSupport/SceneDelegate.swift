//
//  SceneDelegate.swift
//  CineNest
//
//  Created by Peter on 04/06/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let splashViewController = SplashViewController()
        let navigationController = UINavigationController(
            rootViewController: splashViewController
        )
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

