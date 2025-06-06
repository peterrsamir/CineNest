//
//  BaseViewController.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import UIKit

class BaseViewController: UIViewController {
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        let backImage: UIImage = .backButton
//        self.navigationController?.navigationBar.backIndicatorImage = backImage
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.backItem?.title = ""
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
