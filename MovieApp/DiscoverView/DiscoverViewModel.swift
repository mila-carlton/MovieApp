//
//  DiscoverViewModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import Foundation

final class GenresViewModel {
    
    private var genres: [Genre] = []
    var onUpdate: (() -> Void)?
    private let webService = WebService.shared
        
    func fetchGenres() {
        webService.fetchGenres { [weak self] genres in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.genres = genres ?? []
                self.onUpdate?()
            }
        }
    }
    
    func numberOfGenres() -> Int {
        genres.count
    }
    func genre(at indexPath: Int) -> Genre {
        genres[indexPath]
    }
}
