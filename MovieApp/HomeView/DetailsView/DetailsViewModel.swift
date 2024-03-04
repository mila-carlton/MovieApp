//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 15.02.24.
//

import Foundation

final class DetailsViewModel {
   
    private var movieId: Int!
    
    private(set) var movieDetails: MovieDetailsModel?
    private(set) var videoResults: [VideoResult] = []
    private(set) var movieCastResults: [Cast] = []
    private(set) var similarMovies: [MovieListResult] = []
    
    private let webService = WebService.shared
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func fetchDetails(complete: @escaping (()->Void) ) {
        webService.fetchDetails(movieId: movieId) { [weak self] details in
            guard let self = self, let movieDetails = details else {
                complete()
                return }
            self.movieDetails = movieDetails
            complete()
        }
    }
    
    func fetchVideos(completion: @escaping (()->Void) ) {
        webService.fetchVideo(id: movieId) { [weak self] video in
            guard let self = self, let videoDetails = video else { completion()
                return }
            self.videoResults = videoDetails
            completion()
        }
    }
    
    func fetchCast(completion: @escaping(()->Void) ) {
        webService.fetchCast(id: movieId) { [weak self] casts in
            guard let self = self, let allCast = casts else { completion ()
                return }
            self.movieCastResults = allCast
            completion()
        }
    }
    
    func fetchSimilar(completion: @escaping(() -> Void)) {
        webService.fetchSimilar(id: movieId) { [weak self] similar in
            guard let self = self, let allSimilar = similar else { completion()
            return }
            self.similarMovies = allSimilar
            completion()
        }
    }
    
}
