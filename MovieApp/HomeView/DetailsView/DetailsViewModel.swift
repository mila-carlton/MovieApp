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
    
}
