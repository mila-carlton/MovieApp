//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import Foundation

struct HomeMovies {
    let title: String
    let movieList: [MovieListResult]
}


final class HomeViewModel {
    private var movies: [MovieListResult] = []
    let webService = WebService.shared
    
    var homeMovies: [HomeMovies] = []
    
    func fetchPopularMovies(complete: @escaping (()->Void)) {
        webService.fetchMovieList(url: .popular) { [weak self] popularMovieListResponse in
            guard let self = self else { return }
            self.homeMovies.append(HomeMovies(title: "Popular", movieList: popularMovieListResponse?.results ?? []))
            complete()
        }
    }
    
    func fetchTrendMovie(completion: @escaping(()->Void)) {
        webService.fetchMovieList(url: .trending) { [weak self] trendingMovie in
            guard let self = self else { return }
            self.homeMovies.append(HomeMovies(title: "Trending", movieList: trendingMovie?.results ?? [] ))
            completion()
        }
    }
    
    func fetchNowPlayingMovie(completion: @escaping(()->Void)) {
        webService.fetchMovieList(url: .nowPlaying) { [weak self] nowPlaying in
            guard let self = self else { return }
            self.homeMovies.append(HomeMovies(title: "Now playing", movieList: nowPlaying?.results ?? [] ))
            completion()
        }
    }
    
    func fetchTopRatedMovie(completion: @escaping(()->Void)) {
        webService.fetchMovieList(url: .topRated) { [weak self] topRated in
            self?.homeMovies.append(HomeMovies(title: "Top rated", movieList: topRated?.results ?? [] ))
            completion()
        }
    }
    
    func numberOfRowsInSection() -> Int {
        homeMovies.count
    }
    
    func cellForRowAt(index: Int) -> HomeMovies {
        return homeMovies[index]
    }
}

