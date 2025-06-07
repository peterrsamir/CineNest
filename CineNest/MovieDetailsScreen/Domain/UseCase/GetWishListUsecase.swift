//
//  GetWishListUsecase.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation

protocol GetWishListUsecaseContract {
    func addMovieToWishList(id: String, isWishListed: Bool)
    func isMovieWishListed(id: String) -> Bool
}

struct GetWishListUsecase: GetWishListUsecaseContract {
    
    private let repository: WishListRepositoryContract
    
    init(repository: WishListRepositoryContract) {
        self.repository = repository
    }
    
    func addMovieToWishList(id: String, isWishListed: Bool){
        repository.setWishList(id: id, isWishListed: isWishListed)
    }
    
    func isMovieWishListed(id: String) -> Bool {
        return repository.isMovieWishListed(id: id)
    }
}

