//
//  CastDetailsViewModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 10.03.24.
//

import Foundation

final class CastDetailsViewModel {
    private var movieId: Int!
    
    private(set) var castDetails: CastDetailsModel
    
    private let webService = WebService.shared
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func fetchCastDetails(complete: @escaping (()->Void) ) {
        webService.fetchCastDetails(id: movieId) { [weak self] details in
            guard let self = self, let castDetails = details else {
                complete()
                return }
            self.castDetails = castDetails
            complete()
        }
    }
}
