//
//  MovieForGenresViewModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 19.02.24.
//

import Foundation

final class MovieForGenresViewModel {
    
    var movies: [DiscoverResult] = []
    var originalMovies: [DiscoverResult] = []
    var genreId: Int!
    var onUpdate: (() -> Void)?
    
    private let webService = WebService.shared
    
    init() {}
    
    init(id: Int) {
        self.genreId = id
    }
    
    func fetchDiscover() {
        
        webService.fetchDiscover(movieId: genreId) { [weak self] discover in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.originalMovies = discover?.filter { $0.genreIDS?.contains(self.genreId) ?? false } ?? []
                self.movies = self.originalMovies
                self.onUpdate?()
            }
        }
    }
}
