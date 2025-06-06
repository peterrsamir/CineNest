//
//  HomeUseCase.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import RxSwift

protocol HomeUseCaseContract {
    func execute(page: Int) -> Observable<[Movie]>
}

struct HomeUseCase: HomeUseCaseContract {
    
    private let repository: HomeRepositoryContract
    
    init(repository: HomeRepositoryContract) {
        self.repository = repository
    }
    
    func execute(page: Int) -> Observable<[Movie]> {
        return repository.fetchMovies(page: page)
            .map { movies in
                let grouped = groupByYear(movies)
                return grouped.flatMap { $0.movies }
            }
    }
}

// MARK: - Arrange items by year
extension HomeUseCase {
    private func groupByYear(_ movies: [Movie]) -> [YearlyMovieModel] {
        let grouped = Dictionary(grouping: movies) { movie -> String in
            movie.releaseDate?.split(separator: "-").first.map(String.init) ?? "Unknown"
        }
        return grouped.map { YearlyMovieModel(year: $0.key, movies: $0.value) }
            .sorted { $0.year > $1.year }
    }
}
