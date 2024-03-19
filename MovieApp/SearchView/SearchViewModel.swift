//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 05.03.24.
//

import Foundation

final class SearchViewModel {
    
    var movies: [SearchResult] = []
    var query = ""
    private let webService = WebService.shared
    
    
    func getSearchMovies(query: String, completion: @escaping(()->Void)) {
        webService.fetchSearch(query: query) { [weak self] results in
            guard let self = self else { return }
            if let searchResult = results {
                self.movies.removeAll()
                self.movies = searchResult
                completion()
            } else {
                print("Search error")
            }
        }
    }
}
