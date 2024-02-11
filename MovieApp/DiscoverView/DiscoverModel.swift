//
//  DiscoverModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import Foundation

struct Genres: Decodable {
    var genres: [Genre]?
}

struct Genre: Decodable {
    var id: Int?
    var name: String?
}
