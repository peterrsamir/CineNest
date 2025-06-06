//
//  HomeRepository.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import Foundation
import RxSwift

struct HomeRepository: HomeRepositoryContract {
    
    private let remoteDataSource: HomeRemoteDataSourceContract
    
    init(remoteDataSource: HomeRemoteDataSourceContract) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchMovies(page: Int) -> Observable<[Movie]> {
        return Observable.create { observer in
            self.remoteDataSource.getMovies(page: "\(page)") { result in
                switch result {
                case .success(let movies):
                    observer.onNext(movies ?? [])
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
