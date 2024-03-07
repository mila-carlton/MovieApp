//
//  MovieEntity+CoreDataProperties.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 07.03.24.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var movidid: Int32
    @NSManaged public var movieTitle: String?
    @NSManaged public var trailerFilePath: String?

}

extension MovieEntity : Identifiable {

}
