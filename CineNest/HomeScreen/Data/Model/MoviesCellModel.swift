//
//  HomeTableViewCellModel.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import Foundation

struct MoviesCellModel {
    let id: Int?
    let movieImage: String?
    let movieTitle: String?
    let movieDesc: String?
    let rating: String?
    let votingCount: String?
    
    init(id: Int?, image: String?, movieTitle: String?, movieDesc: String?, rating: Double?, votingCount: Int?) {
        self.id = id
        self.movieImage = Constants.APIConstatnts.imageBaseURL + (image ?? "")
        self.movieTitle = movieTitle
        self.movieDesc = movieDesc
        self.rating  = "\(rating ?? 0.0)/10"
        self.votingCount = "\("Votes".localized): \(votingCount ?? 0)"
    }
}
