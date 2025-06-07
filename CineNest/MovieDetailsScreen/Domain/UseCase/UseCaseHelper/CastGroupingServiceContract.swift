//
//  CastGroupingServiceContract.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation

protocol CastGroupingServiceContract {
    func groupCastByCategory(_ cast: [MovieCastModel]) -> [CastingSection]
}

class CastGroupingService: CastGroupingServiceContract {
    func groupCastByCategory(_ cast: [MovieCastModel]) -> [CastingSection] {
        let topActing = cast
            .filter { $0.knownForDepartment == Departement.Acting.rawValue }
            .sorted { ($0.popularity ?? 0) > ($1.popularity ?? 0) }
            .prefix(5)

        let topDirecting = cast
            .filter { $0.knownForDepartment == Departement.Directing.rawValue }
            .sorted { ($0.popularity ?? 0) > ($1.popularity ?? 0) }
            .prefix(5)

        let filteredCast = Array(topActing + topDirecting)

        let groupedDict = Dictionary(grouping: filteredCast) { $0.knownForDepartment ?? "" }

        return groupedDict
            .map { CastingSection(department: $0.key, casts: $0.value) }
            .sorted {
                ($0.casts.first?.popularity ?? 0) > ($1.casts.first?.popularity ?? 0)
            }
    }
}
