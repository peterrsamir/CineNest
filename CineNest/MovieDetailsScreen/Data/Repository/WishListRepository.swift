//
//  WishListRepository.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation

protocol WishListRepositoryContract {
    func isMovieWishListed(id: String) -> Bool
    func setWishList(id: String, isWishListed: Bool)
}

struct WishListRepository: WishListRepositoryContract {
   
    private let wishListDataSource: MovieWishListLocalDataSourceContract
    
    init(wishListDataSource: MovieWishListLocalDataSourceContract) {
        self.wishListDataSource = wishListDataSource
    }
    
    func isMovieWishListed(id: String) -> Bool {
        return wishListDataSource.isMovieWishListed(id: id)
    }
    
    func setWishList(id: String, isWishListed: Bool) {
        wishListDataSource.setWishList(id: id, isWishListed: isWishListed)
    }
}


