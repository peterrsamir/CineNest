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
    }
}
