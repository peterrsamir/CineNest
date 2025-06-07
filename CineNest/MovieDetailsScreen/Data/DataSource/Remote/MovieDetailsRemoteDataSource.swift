//
//  MovieDetailsRemoteDataSource.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import Foundation

protocol MovieDetailsRemoteDataSourceContract {
    func getMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetailsModel?, NSError>) -> Void)
    func getSimilarMovies(movieID: Int, completion: @escaping (Result<[Movie]?, NSError>) -> Void)
}
    
final class MovieDetailsRemoteDataSource : BaseApi<MovieDetailsConfigurations>, MovieDetailsRemoteDataSourceContract {
    
    func getMovieDetails(
        movieID: Int,
        completion: @escaping (Result<MovieDetailsModel?, NSError>) -> Void
    ) {
        
        fetchData(
            target: .getMovieDetailsBy(id: movieID),
            responseType: MovieDetailsModel.self
        ) { (result) in
            switch result {
            case .success(let movieDetailsModel):
                completion(.success(movieDetailsModel))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    func getSimilarMovies(movieID: Int, completion: @escaping (Result<[Movie]?, NSError>) -> Void) {
        fetchData(
            target: .getSimilarMovies(id: movieID),
            responseType: MoviesModel.self
        ) { (result) in
            switch result {
            case .success(let moviesModel):
                completion(.success(moviesModel.movies))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}

