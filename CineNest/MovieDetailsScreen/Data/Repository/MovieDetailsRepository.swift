//
//  MovieDetailsRepository.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation
import RxSwift

struct MovieDetailsRepository: MovieDetailsRepositoryContract {
    private let remoteDataSource: MovieDetailsRemoteDataSourceContract
    
    init(remoteDataSource: MovieDetailsRemoteDataSourceContract) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchMovieDetails(movieID: Int) -> Observable<MovieDetailsModel> {
        return Observable.create { observer in
            remoteDataSource.getMovieDetails(movieID: movieID) {
                switch $0 {
                case .success(let movieDetails):
                    if let movieDetails = movieDetails {
                        observer.onNext(movieDetails)
                    }
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchSimilarMovies(movieID: Int) -> Observable<[Movie]> {
        return Observable.create { observer in
            remoteDataSource.getSimilarMovies(movieID: movieID) {
                switch $0 {
                case .success(let movieDetails):
                    if let movieDetails = movieDetails {
                        observer.onNext(movieDetails)
                    }
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchCastFromSimilarMovies(movieID: Int) -> Observable<[MovieCastModel]> {
        return Observable.create { observer in
            remoteDataSource.getCastsFromSimilarMovies(movieID: movieID) {
                switch $0 {
                case .success(let movieDetails):
                    if let movieDetails = movieDetails {
                        observer.onNext(movieDetails)
                    }
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
