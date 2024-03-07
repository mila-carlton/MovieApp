//
//  DownloadsViewModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import Foundation

final class DownloadsViewModel {
    
    var savedMovies: [SavedMovieModel] = []
    
    func getDownloadedMovies(completion: @escaping (() ->Void)) {
        StorageManager.shared.fetchMovies { [weak self] movies in
            guard let self = self else { return }
            self.savedMovies = movies
            completion()
        }
    }
    
    func saveMovie(movie: SavedMovieModel, completion: @escaping (() ->Void)) {
        StorageManager.shared.insertMovie(movie: movie) {
            completion()
        }
    }
    
    func deleteMovie() {}
    
    
}


struct SavedMovieModel {
    let title: String
    let filePath: String
    let movieId: Double
}
