//
//  StorageManager.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.03.24.
//

import Foundation
import CoreData

final class StorageManager {
    static let shared = StorageManager()
    
    private let context: NSManagedObjectContext
    
    private init() {
        context = persistentContainer.viewContext
    }
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func insertMovie(movie: SavedMovieModel, completion: @escaping () -> Void) {
        let movieEntity = MovieEntity(context: context)
        movieEntity.movieTitle = movie.title
        movieEntity.trailerFilePath = movie.filePath
        movieEntity.movidid = Int32(movie.movieId)
        
        saveContext()
        completion()
    }
    
    
    func fetchMovies(completion: @escaping ([SavedMovieModel]) -> Void) {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        do {
            let savedMovies = try context.fetch(fetchRequest)
            let movies = savedMovies.map { SavedMovieModel(title: $0.movieTitle ?? "", filePath: $0.trailerFilePath ?? "", movieId: Double($0.movidid)) }
            completion(movies)
        } catch {
            print("Could not fetch movies: \(error)")
            completion([])
        }
    }
    
    func deleteMovie(movieId: Double) {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "movidid == %lf", movieId)
        
        do {
            if let movieToDelete = try context.fetch(fetchRequest).first {
                context.delete(movieToDelete)
                saveContext()
            } else {
                print("Movie with ID \(movieId) not found.")
            }
        } catch {
            print("Error deleting movie: \(error)")
        }
    }

    
}
