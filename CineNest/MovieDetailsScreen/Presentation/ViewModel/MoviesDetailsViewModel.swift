//
//  MoviesDetailsViewModel.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation
import RxSwift
import RxRelay

class MoviesDetailsViewModel: MoviesDetailsViewModelContract {
    
    // MARK: - Observables
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    var errorObservable: PublishSubject<String> = PublishSubject<String>()
    
    // MARK: - Dependencies
    private var disposeBag: DisposeBag
    private let movieID: Int
    private let getMovieDetailsUsecase: GetMovieDetailsUsecaseContract
    private let getSimilarMoviesUseCase: GetSimilarMoviesUsecaseContract
    
    // MARK: - State
    var movieDetailsModel: BehaviorRelay<MovieDetailsModel?> = BehaviorRelay(value: nil)
    var similarMovies: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    
    // MARK: - Init
    init(
        getMovieDetailsUsecase: GetMovieDetailsUsecaseContract,
        getSimilarMoviesUseCase: GetSimilarMoviesUsecaseContract,
        movieID: Int
    ) {
        disposeBag = DisposeBag()
        self.getMovieDetailsUsecase = getMovieDetailsUsecase
        self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
        self.movieID = movieID
        
        // Data
        getMovieDetails()
        getSimilarMovies()
    }
    
    // MARK: APIs
    private func getMovieDetails() {
        getMovieDetailsUsecase
            .execute(movieID: self.movieID)
            .subscribe(onNext: {[weak self] movieDetailsModel in
                self?.movieDetailsModel.accept(movieDetailsModel)
            }, onError: { [weak self] error in
                self?.handleError(error: error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    private func getSimilarMovies() {
        getSimilarMoviesUseCase.execute(movieID: movieID)
            .subscribe(onNext: { [weak self] movies in
                self?.similarMovies.accept(movies)
            }, onError: { [weak self] error in
                self?.handleError(error: error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Private Helpers
    private func handleError(error: String) {
        errorObservable.onNext(error)
        isLoading.onNext(false)
    }
}
