//
//  BaseAPI.swift
//  CineNest
//
//  Created by Peter on 05/06/2025.
//

import Foundation
import Alamofire

class BaseApi<T: TargetType> {
    
    func fetchData<M: Codable>(
        target: T,
        responseType: M.Type,
        completion: @escaping (Result<M, NSError>) -> Void
    ) {
        let method = HTTPMethod(rawValue: target.method.rawValue)
        let headers = HTTPHeaders(target.headers ?? [:])
        let (parameters, encoding) = buildParams(task: target.parameters ?? .requestPlain)
        let url = target.baseURL + target.path
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
        .validate()
        .responseData { response in
            self.handleResponse(
                response,
                url: url,
                responseType: M.self,
                completion: completion
            )
        }
    }

    // MARK: - Handle Response Methods
    private func handleResponse<M: Decodable>(
        _ response: AFDataResponse<Data>,
        url: String,
        responseType: M.Type,
        completion: @escaping (Result<M, NSError>) -> Void
    ) {
        guard let statusCode = response.response?.statusCode else {
            let error = self.createError(domain: url, code: 0, message: "No response from server.")
            completion(.failure(error))
            return
        }
        switch response.result {
        case .success(let data):
            self.handleSuccessResponse(
                data: data,
                statusCode: statusCode,
                url: url,
                responseType: responseType,
                completion: completion
            )
        case .failure(let error):
            completion(.failure(error as NSError))
        }
    }
    
    private func handleSuccessResponse<M: Decodable>(
        data: Data,
        statusCode: Int,
        url: String,
        responseType: M.Type,
        completion: @escaping (Result<M, NSError>) -> Void
    ) {
        do {
            if (200..<300).contains(statusCode) {
                let decoded = try JSONDecoder().decode(M.self, from: data)
                completion(.success(decoded))
            } else {
                let error = self.createError(
                    domain: url,
                    code: statusCode,
                    message: "Unexpected status code: \(statusCode)"
                )
                completion(.failure(error))
            }
        } catch {
            completion(.failure(error as NSError))
        }
    }
    
    private func createError(domain: String, code: Int, message: String) -> NSError {
        return NSError(
            domain: domain,
            code: code,
            userInfo: [NSLocalizedDescriptionKey: message]
        )
    }
    
    // MARK: - Build Parameters
    private func buildParams(task: ParametersType) -> ([String: Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(let parameters, let encoding):
            return (parameters, encoding)
        }
    }
}

