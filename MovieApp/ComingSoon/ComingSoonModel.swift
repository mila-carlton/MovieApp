//
//  ComingSoonModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import Foundation

struct SoonMovieResponse: Decodable {
    let results: [SoonMovie]?
}

struct SoonMovie: Decodable {
    let genreIds: [Int]?
    let id: Int?
    let originalTitle: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        
        
    }
}
