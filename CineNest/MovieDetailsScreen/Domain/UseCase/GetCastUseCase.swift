//
//  GetCastUseCase.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation
import RxSwift

protocol GetCastUseCaseContract {
    func fetchGroupedCastFromSimilars(_ similars: [Movie]) -> Observable<[CastingSection]>
}

struct GetCastUseCase: GetCastUseCaseContract {
    
    private let repository: MovieDetailsRepositoryContract
    private let CastGroupingServiceContract: CastGroupingServiceContract
    init(
        repository: MovieDetailsRepositoryContract,
        CastGroupingServiceContract: CastGroupingServiceContract
    ) {
        self.repository = repository
        self.CastGroupingServiceContract = CastGroupingServiceContract
    }
    
    private func execute(movieID: Int) -> Observable<[MovieCastModel]> {
        return repository.fetchCastFromSimilarMovies(movieID: movieID)
    }
    
    func fetchGroupedCastFromSimilars(_ similars: [Movie]) -> Observable<[CastingSection]> {
        guard !similars.isEmpty else {
            return Observable.just([])
        }
        return Observable.from(similars)
            .compactMap { $0.id }
            .flatMap { movieId -> Observable<[MovieCastModel]> in
                self.execute(movieID: movieId)
                    .catch { error in
                        return Observable.just([])
                    }
            }
            .toArray()
            .map { allCasts in
                let flat = allCasts.flatMap { $0 }
                return CastGroupingServiceContract.groupCastByCategory(flat)
            }
            .asObservable()
    }
}

