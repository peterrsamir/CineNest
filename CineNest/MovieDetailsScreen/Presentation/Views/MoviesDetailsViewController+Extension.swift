//
//  MoviesDetailsViewController+Extension.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import UIKit

extension MoviesDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width / 2)
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }   
}
