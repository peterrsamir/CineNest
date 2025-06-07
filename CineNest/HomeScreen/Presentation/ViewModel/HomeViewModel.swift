//
//  HomeViewModel.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import RxSwift
import RxCocoa

class HomeViewModel: HomeViewModelContract {
    // MARK: - Observables
    var errorObservable: PublishSubject<String> = PublishSubject<String>()
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    var moviesGroupedByYear: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    var searchedMovies = BehaviorRelay<[Movie]>(value: [])
    // MARK: - Dependencies
    private let getMoviesUseCase: GetMoviesUseCaseContract
    private let searchMoviesUseCase: SearchMoviesUseCaseContract
    private let wishListUseCase: GetWishListUsecaseContract
    private let disposeBag = DisposeBag()
    // MARK: - State
    private var currentPage = 1
    private var canLoadMore = true
    private var isSearchMode = false
    // MARK: - Init
    init(
        getMoviesUseCase: GetMoviesUseCaseContract,
        searchMoviesUseCase: SearchMoviesUseCaseContract,
        wishListUseCase: GetWishListUsecaseContract
    ) {
        self.getMoviesUseCase = getMoviesUseCase
        self.searchMoviesUseCase = searchMoviesUseCase
        self.wishListUseCase = wishListUseCase
        fetchMovies(page: 1)
    }
    // MARK: - Public Methods
    func fetchMovies(page: Int = 1) {
        isLoading.onNext(true)
        getMoviesUseCase.execute(page: page)
            .subscribe(
                onNext: { [weak self] movies in
                self?.handleFetchSuccess(movies: movies, page: page)
            },
            onError: { [weak self] error in
                self?.handleError(error: error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    func searchMovies(page: Int, query: String?) {
        let trimmedQuery = query?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !trimmedQuery.isEmpty else {
            isSearchMode = false
            searchedMovies.accept(moviesGroupedByYear.value)
            return
        }
        isSearchMode = true
        isLoading.onNext(true)
        searchMoviesUseCase.execute(page: page, query: trimmedQuery)
            .subscribe(onNext: { [weak self] movies in
                self?.handleSearchSuccess(movies: movies, page: page)
            },
            onError: { [weak self] error in
                self?.handleError(error: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func loadNextPageIfNeeded(currentIndex: Int, query: String? = nil) {
        // Assuming you want to load more when the user reaches the last 5 items
        let threshold = searchedMovies.value.count - 5
        guard currentIndex >= threshold, canLoadMore else { return }
        if isSearchMode {
            searchMovies(page: currentPage + 1, query: query)
        } else {
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
    
    func isMovieWishListed(movieID: String) -> Bool {
        return self.wishListUseCase.isMovieWishListed(id: movieID)
    }
    // MARK: - Private helper methods
    private func handleFetchSuccess(movies: [Movie], page: Int) {
        isLoading.onNext(false)
        var current = (page == 1) ? [] : moviesGroupedByYear.value
        current.append(contentsOf: movies)
        moviesGroupedByYear.accept(current)
        if !isSearchMode {
            searchedMovies.accept(current)
        }
        canLoadMore = !movies.isEmpty
        currentPage = page
    }
    private func handleSearchSuccess(movies: [Movie], page: Int) {
        isLoading.onNext(false)
        var updated = (page == 1) ? [] : searchedMovies.value
        updated.append(contentsOf: movies)
        searchedMovies.accept(updated)
        
        canLoadMore = !movies.isEmpty
        currentPage = page
    }
    private func handleError(error: String){
        isLoading.onNext(false)
        errorObservable.onNext(error)
    }
}
