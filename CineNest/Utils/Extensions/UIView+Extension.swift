//
//  UIView+Extension.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import UIKit

extension UIView {
    func makeBoardered(color: UIColor = .red, width: CGFloat = 2, cornerRadius: CGFloat = 8) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}
