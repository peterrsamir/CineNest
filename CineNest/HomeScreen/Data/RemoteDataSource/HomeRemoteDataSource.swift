//
//  HomeRemoteDataSource.swift
//  CineNest
//
//  Created by Peter on 05/06/2025.
//

import Foundation

protocol HomeRemoteDataSourceContract {
    func getMovies(page: String, completion: @escaping (Result<[Movie]?, NSError>) -> Void)
    func getSearchedMovies(page: String, query: String?, completion: @escaping (Result<[Movie]?, NSError>) -> Void)
}
    
final class HomeRemoteDataSource : BaseApi<HomeConfigurations>, HomeRemoteDataSourceContract {
    
    func getMovies(page: String, completion: @escaping (Result<[Movie]?, NSError>) -> Void) {
        fetchData(target: .getMovies(page: page), responseType: MoviesModel.self) { (result) in
            switch result {
            case .success(let movieModel):
                completion(.success(movieModel.movies))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    func getSearchedMovies(page: String, query: String?, completion: @escaping (Result<[Movie]?, NSError>) -> Void) {
        fetchData(target: .searchMovies(page: page, query: query), responseType: MoviesModel.self) { (result) in
            switch result {
            case .success(let movieModel):
                completion(.success(movieModel.movies))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}

