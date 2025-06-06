//
//  HomeViewModel.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import RxSwift
import RxCocoa

class HomeViewModel: HomeViewModelContract {
    var errorObservable: PublishSubject<String> = PublishSubject<String>()
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    var items: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    private let useCase: HomeUseCaseContract
    private let disposeBag = DisposeBag()
    private var currentPage = 1
    private var canLoadMore = true
    
    init(useCase: HomeUseCaseContract) {
        self.useCase = useCase
        fetchMovies(page: 1)
    }
    
    func fetchMovies(page: Int = 1) {
        isLoading.onNext(true)
        useCase.execute(page: page)
            .subscribe(onNext: { [weak self] movies in
                guard let self else { return }
                isLoading.onNext(false)
                var current = items.value
                current.append(contentsOf: movies)
                items.accept(current)
                // for pagination
                self.canLoadMore = !movies.isEmpty
                currentPage = page
            }, onError: { [weak self] error in
                self?.errorObservable.onNext(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    func loadNextPageIfNeeded(currentIndex: Int) {
        // Assuming you want to load more when the user reaches the last 5 items
        let threshold = items.value.count - 5
        if currentIndex >= threshold && canLoadMore {
            fetchMovies(page: currentPage + 1)
        }
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
