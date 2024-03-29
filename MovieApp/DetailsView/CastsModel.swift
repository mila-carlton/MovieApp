//
//  CastsModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 01.03.24.
//

import Foundation

struct CastsResponse: Codable {
    let id: Int?
    let cast, crew: [Cast]?
}

struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}


extension Cast: MovieItemProtocol {
    var imagePath: String {
        return profilePath ?? ""
    }
}
