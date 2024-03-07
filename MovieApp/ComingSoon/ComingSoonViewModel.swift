//
//  ComingSoonViewModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import Foundation

final class ComingSoonViewModel {
    
    private var soonMovies: [SoonMovie] = []
    var onUpdate: (() -> Void)?
    
    private let webService = WebService.shared
    
    func fetchUpComingMovies() {
        webService.fetchUpComing { [weak self] soonMovie in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.soonMovies = soonMovie ?? []
                self.onUpdate?()
            }
        }
    }
        
    func numberOfSoonMovies() -> Int {
        soonMovies.count
    }
    func cellForRowAt(at index: Int) -> SoonMovie {
        return soonMovies[index]
    }
    }

