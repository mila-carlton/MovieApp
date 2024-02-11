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
    
    var homeMoview: [HomeMovies] = []
    
    func fetchPopularMovies(complete: @escaping (()->Void)) {
        webService.fetchMovieList(url: .popular) { [weak self] popularMovieListResponse in
            guard let self = self else { return }
            self.homeMoview.append(HomeMovies(title: "Popular", movieList: popularMovieListResponse?.results ?? []))
            complete()
        }
    }
    
    func fetchTrendMovie(completion: @escaping(()->Void)) {
        webService.fetchMovieList(url: .trending) { [weak self] trendingMovie in
            guard let self = self else { return }
            self.homeMoview.append(HomeMovies(title: "Trending", movieList: trendingMovie?.results ?? []))
            completion()
        }
    }
    func numberOfRowsInSection() -> Int {
        homeMoview.count
    }
    
    func cellForRowAt(index: Int) -> HomeMovies {
        return homeMoview[index]
    }
}

