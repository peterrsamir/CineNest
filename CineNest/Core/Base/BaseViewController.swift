//
//  BaseViewController.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import UIKit

class BaseViewController: UIViewController {
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearance()
    }
    
    func showLoading() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        activityIndicator.color = .red
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showAlert(title:String,body:String,actions:[UIAlertAction]){
        let alert = UIAlertController(title: title, message: body, preferredStyle: UIAlertController.Style.alert)
        for action in actions{
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    private func setNavigationBarAppearance() {
        self.title = "CineNest".localized
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.red
        ]
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.tintColor = .red
    }
}
