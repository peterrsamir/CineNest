//
//  CastingTableViewCell.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import UIKit

class CastingTableViewCell: UITableViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(image: String, name: String) {
        castImageView.setURLImage(url: image)
        castNameLabel.text = name
    }
    
}
