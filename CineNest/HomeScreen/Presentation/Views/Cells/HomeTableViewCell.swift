//
//  HomeTableViewCell.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var movieTitleBackgroundView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var viewsLabel: UILabel!
    @IBOutlet private weak var raingLabel: UILabel!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet weak var wishListImage: UIImageView!
    
    func setupCell(cellModel: MoviesCellModel, isWishListed: Bool) {
        movieTitle.text = cellModel.movieTitle
        movieImage.kf.indicatorType = .activity
        movieImage.setURLImage(url: cellModel.movieImage ?? "")
        descriptionLabel.text = cellModel.movieDesc
        raingLabel.text = cellModel.rating
        viewsLabel.text = cellModel.votingCount
        movieTitleBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        wishListImage.tintColor = isWishListed ? UIColor.orange : UIColor.gray
    }
}
