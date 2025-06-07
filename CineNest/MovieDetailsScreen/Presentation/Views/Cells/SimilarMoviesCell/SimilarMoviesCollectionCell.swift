//
//  SimilarMoviesCollectionCell.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import UIKit

class SimilarMoviesCollectionCell: UICollectionViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.makeBoardered()
        movieImage.contentMode = .scaleAspectFill
        movieImage.clipsToBounds = true
    }

    func setup(name: String, image: String) {
        movieImage.setURLImage(url: image)
        movieName.text = name
    }
}
