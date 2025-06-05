//
//  HomeRemoteDataSource.swift
//  CineNest
//
//  Created by Peter on 05/06/2025.
//

import Foundation

class HomeRemoteDataSource : BaseApi<HomeConfigurations> {
    
    func getMovies(page: String, completion: @escaping (Result<[Movie]?, NSError>) -> Void) {
        self.fetchData(target: .getMovies(page: page), responseType: MoviesModel.self) { (result) in
            switch result {
            case .success(let movieModel):
                completion(.success(movieModel.movies))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}

