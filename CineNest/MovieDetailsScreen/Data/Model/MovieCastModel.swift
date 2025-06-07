//
//  MovieCastModel.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation
import RxDataSources

struct CastResponse: Codable{
    var id: Int?
    var cast: [MovieCastModel]?
    
    enum CodingKeys: String, CodingKey {
        case id ,cast
    }
}
struct MovieCastModel: Codable, Hashable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}


enum Departement: String, Codable {
    case Acting = "Acting"
    case Directing = "Directing"
}

struct CastingSection {
    let department: String
    var casts: [MovieCastModel]
}

extension CastingSection: SectionModelType {
    typealias Item = MovieCastModel

    init(original: CastingSection, items: [MovieCastModel]) {
        self = original
        self.casts = items
    }

    var items: [MovieCastModel] {
        return casts
    }
}
