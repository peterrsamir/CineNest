//
//  MovieDetailsLocalDataSource.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation

protocol MovieWishListLocalDataSourceContract {
    func isMovieWishListed(id: String) -> Bool
    func setWishList(id: String, isWishListed: Bool)
}

struct MovieWishListLocalDataSource: MovieWishListLocalDataSourceContract {
   
    private let wishListDictionaryKey = "wishList"
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func isMovieWishListed(id: String) -> Bool {
        let dict = userDefaults.dictionary(forKey: wishListDictionaryKey) as? [String: Bool] ?? [:]
        return dict[id] ?? false
    }
    
    func setWishList(id: String, isWishListed: Bool) {
        var dict = userDefaults.dictionary(forKey: wishListDictionaryKey) as? [String: Bool] ?? [:]
        dict[id] = isWishListed
        userDefaults.set(dict, forKey: wishListDictionaryKey)
        userDefaults.synchronize()
        postWishListUpdatesNotification()
    }
    
    func postWishListUpdatesNotification() {
        NotificationCenter.default.post(name: .wishListUpdated, object: nil)
    }
}

