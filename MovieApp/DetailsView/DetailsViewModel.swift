//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 15.02.24.
//

import Foundation

final class DetailsViewModel {
   
    private var movieId: Int!
    
    private(set) var movieDetails: MovieDetailsModel?
    private(set) var videoResults: [VideoResult] = []
    private(set) var movieCastResults: [Cast] = []
    private(set) var similarMovies: [MovieListResult] = []
    
    private let webService = WebService.shared
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func fetchDetails(complete: @escaping (()->Void) ) {
        webService.fetchDetails(movieId: movieId) { [weak self] details in
            guard let self = self, let movieDetails = details else {
                complete()
                return }
            self.movieDetails = movieDetails
            complete()
        }
    }
    
    func fetchVideos(completion: @escaping (()->Void) ) {
        webService.fetchVideo(id: movieId) { [weak self] video in
            guard let self = self, let videoDetails = video else { completion()
                return }
            self.videoResults = videoDetails
            completion()
        }
    }
    
    func fetchCast(completion: @escaping(()->Void) ) {
        webService.fetchCast(id: movieId) { [weak self] casts in
            guard let self = self, let allCast = casts else { completion ()
                return }
            self.movieCastResults = allCast
            completion()
        }
    }
    
    func fetchSimilar(completion: @escaping(() -> Void)) {
        webService.fetchSimilar(id: movieId) { [weak self] similar in
            guard let self = self, let allSimilar = similar else { completion()
            return }
            self.similarMovies = allSimilar
            completion()
        }
    }
    
    func downloadVideo(movieTitle: String, trailerId: String, completion: @escaping(() -> Void)) {
        // Example usage:
        let videoURL = URL(string: "https://www.youtube.com/watch?v=\(trailerId)")!
        //let videoURL = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!
        
        
        //let videoURL = URL(string: "https://www.youtube.com/watch?v=t433PEQGErc")!
        let saveURL = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask).first!.appendingPathComponent("\(trailerId).mp4")
        
        DispatchQueue.global(qos: .background).async {
            NetworkRequest.shared.downloadYouTubeVideo(from: videoURL, saveTo: saveURL) { error in
             
                    StorageManager.shared.insertMovie(movie: SavedMovieModel(title: movieTitle, filePath: saveURL.absoluteString, movieId: Double(self.movieId ?? 0))) {
                        completion()
                    }
                            }

        }
        
    }
    
}


class DownloadViewModel: NSObject, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            
        }
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
           
        }
    
    var progress: Float = 0
    
    
    
    
    /*
    
    
    func downloadTrailer(item: VideoResult, cancelDownload: Bool, complete: @escaping(String?, Double?)->()) {
            if cancelDownload == true {
                mainQueue.cancelAllOperations()
                complete(nil, 0)
            } else {
                mainQueue.addOperation {
                    
                    WebService.shared.downloadVideo(urlString: "https://youtu.be/zAGVQLHvwOY") { [unowned self] progress, url in
                        
                        if progress == 1, let url = url, cancelDownload == false {
                            CoreDataHelper.shared.insertDownloadTrailersData(movieName: movieName, trailerName:  item.name ?? "trailer x", trailerPath: "\(url)")
                            complete(nil, progress)
                        } else if progress < 1, cancelDownload == false {
                            complete(nil, progress)
                        } else if progress == 0 {
                            complete(nil, progress)
                        } else {
                            complete("Error", 0)
                        }
                    }
                }
            }
        }
    
    
    func downloadVideo(urlString: String, completion: @escaping(Double, URL?)->()) {
            
            let url = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            //let url = URL(string: "https://www.youtube.com/watch?v=VS_ub1QaIYQ")
            
            let request = AF.request(url!).downloadProgress(closure: {
                (progress) in
                let pro = progress.fractionCompleted
                completion(pro, nil)
            })
            
            request.responseData { response in
                if let data = response.data {
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let videoURL = documentsURL.appendingPathComponent("video.mp4")
                    do {
                        try data.write(to: videoURL, options: .fileProtectionMask)
                        completion(1, videoURL)
                    } catch {
                        print("Something went wrong!")
                    }
                }
            }
        }
    */
}
