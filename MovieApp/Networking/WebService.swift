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
        case genres = "https://api.themoviedb.org/3/genre/movie/list?language=en"
        case nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1"
        case popular = "https://api.themoviedb.org/3/movie/popular"
        case topRated = "https://api.themoviedb.org/3/movie/top_rated"
        case trending = "https://api.themoviedb.org/3/trending/movie/week"
        case upComing = "https://api.themoviedb.org/3/movie/upcoming"
        case details = "https://api.themoviedb.org/3/movie/"
        case discover = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"
        
    }
    
    func fetchGenres(completion: @escaping (([Genre]?) -> Void) ) {
        let url = URL(string: URLEndpoints.genres.rawValue)!
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
    
    func fetchUpComing(completion: @escaping (([SoonMovie]?) -> Void) ) {
        let url = URL(string: URLEndpoints.upComing.rawValue)!
        NetworkRequest.shared.requestAPI(type: SoonMovieResponse.self, url: url.absoluteString) { result in
            switch result {
            case .success(let soonMovie):
                completion(soonMovie.results ?? [])
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func fetchDetails(movieId: Int, completion: @escaping ((MovieDetailsModel?)-> Void)) {
        let url = URL(string: URLEndpoints.details.rawValue + String(movieId))!
        NetworkRequest.shared.requestAPI(type: MovieDetailsModel.self, url: url.absoluteString) { result in
            switch result {
            case .success(let details):
                completion(details)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func fetchDiscover(movieId: Int, completion: @escaping (([DiscoverResult]?) -> Void) )  {
        let url = URL(string: URLEndpoints.discover.rawValue)!
        NetworkRequest.shared.requestAPI(type: DiscoverMovies.self, url: url.absoluteString) { result in
            switch result {
            case .success(let discover):
                completion(discover.results)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
