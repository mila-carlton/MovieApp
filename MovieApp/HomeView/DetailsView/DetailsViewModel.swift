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
    private(set) var videoView: [VideoResult] = []
    
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
            self.videoView = videoDetails
            print("Video ok")
            completion()
        }
    }
    
}
