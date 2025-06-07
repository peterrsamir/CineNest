//
//  UIImageView+Extension.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setURLImage(url: String) {
        self.kf.setImage(
        with: URL(
            string: Constants.APIConstatnts.imageBaseURL + url
        ),
        placeholder: UIImage(named: "placeholder")
        )
    }
}
