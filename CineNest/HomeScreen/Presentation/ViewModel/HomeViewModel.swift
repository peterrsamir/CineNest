//
//  HomeViewModel.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import RxSwift
import RxCocoa

class HomeViewModel: HomeViewModelContract {
    var items: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    private let useCase: HomeUseCaseContract
    private let disposeBag = DisposeBag()
    
    init(useCase: HomeUseCaseContract) {
        self.useCase = useCase
    }
    
    func fetchMovies(page: Int) -> Observable<[Movie]> {
        return useCase.execute(page: page)
            .do(onNext: { [weak self] movies in
                var current = self?.items.value ?? []
                current.append(contentsOf: movies)
                self?.items.accept(current)
            })
    }
    
    func getMappedCellModelFromMovie(movie: Movie) -> MoviesCellModel {
        MoviesCellModel(
            id: movie.id,
            image: movie.backdropPath,
            movieTitle: movie.title,
            movieDesc: movie.overview,
            rating: movie.voteAverage,
            votingCount: movie.voteCount
        )
    }
}
