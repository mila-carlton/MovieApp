//
//  NetworkRequest.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import Foundation

let apiKey = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOWVkOWMwYjI2N2E2MDg5ODBhYTNkMjc3MzNiNjE3OSIsInN1YiI6IjY1YzEyOGRiYmE0ODAyMDE4MjZmMGI3YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WVUwYdXjnIea8rP0Ny0bot2PNQmH2tjgSNBLojZRd_k"

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    func requestAPI<T: Decodable>(type: T.Type, url: String, method: NetworkMethod = .get, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = ["Authorization": apiKey]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if let jsonData = data {
                self.parse(value: jsonData, completion: completion)
            }
            
        }.resume()
    }
    
    func parse<T: Decodable>(value: Data, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let jsonData = try JSONDecoder().decode(T.self, from: value)
            completion(.success(jsonData))
        } catch {
            completion(.failure(error))
        }
    }
}

enum NetworkMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}
