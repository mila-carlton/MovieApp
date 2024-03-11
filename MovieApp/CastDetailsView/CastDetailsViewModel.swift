//
//  CastDetailsViewModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 10.03.24.
//

import Foundation

final class CastDetailsViewModel {
    private var movieId: Int!
    
    private(set) var castDetails: CastDetailsModel! {
        didSet {
            self.didUpdate?()
        }
    }
    
    private let webService = WebService.shared
    
    var didUpdate: (() -> Void)?
    
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
