//
//  WebService.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import Foundation

final class WebService {
    
    static let shared = WebService()
    private init() { }
    
    enum URLEndpoints: String {
        case discover = "https://api.themoviedb.org/3/genre/movie/list?language=en"
        case nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1"
        case popular = "https://api.themoviedb.org/3/movie/popular"
        case topRated = "https://api.themoviedb.org/3/movie/top_rated"
        case trending = "https://api.themoviedb.org/3/trending/movie/week"
        case upComing = "https://api.themoviedb.org/3/movie/upcoming"
    }
    
    func fetchGenres(completion: @escaping (([Genre]?) -> Void) ) {
        let url = URL(string: URLEndpoints.discover.rawValue)!
        NetworkRequest.shared.requestAPI(type: Genres.self, url: url.absoluteString) { result in
            switch result {
            case .success(let genres):
                completion(genres.genres ?? [])
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    func fetchMovieList(url: URLEndpoints, completion: @escaping((MovieList?) -> Void)) {
        let url = URL(string: url.rawValue)!
        NetworkRequest.shared.requestAPI(type: MovieList.self, url: url.absoluteString) { result in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
        
    }
}
