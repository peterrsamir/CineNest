//
//  Array+Extension.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import Foundation

extension Array where Element == Movie {
    func groupedByYear() -> [YearlyMovieModel] {
        let grouped = Dictionary(grouping: self) { movie -> String in
            movie.releaseDate?.split(separator: "-").first.map(String.init) ?? "Unknown"
        }
        return grouped
            .map { YearlyMovieModel(year: $0.key, movies: $0.value) }
            .sorted { $0.year > $1.year }
    }
}
