//
//  CastDetailsViewModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 10.03.24.
//

import Foundation

final class CastDetailsViewModel {
    private var castId: Int!
    
    private(set) var castDetails: CastDetailsModel! {
        didSet {
            self.didUpdate?()
        }
    }
    
    private(set) var filmographyMovies: [FilmographyCast]?
    
    private let webService = WebService.shared
    
    var didUpdate: (() -> Void)?
    
    init(movieId: Int) {
        self.castId = movieId
    }
    
    
    func fetchCastDetails(complete: @escaping (()->Void) ) {
        webService.fetchCastDetails(id: castId) { [weak self] details in
            guard let self = self, let castDetails = details else {
                complete()
                return }
            self.castDetails = castDetails
            complete()
        }
    }
    
    func fetchFilmography(completion: @escaping(() -> Void) ) {
        webService.fetchFilmography(id: castId) { [weak self] films in
            guard let self = self, let filmsAll = films else {  completion()
                return }
            self.filmographyMovies = filmsAll
            completion()
        }
    }
}


