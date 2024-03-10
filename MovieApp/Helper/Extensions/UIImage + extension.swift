//
//  UIImage + extension.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(imageURL: String) {
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageURL)") {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.2))]) { result in
                switch result {
                case .success(_):
                    //print("Image loaded: \(value.source.url?.absoluteString ?? "")")
                    print("")
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        }
    }
}

//// https://image.tmdb.org/t/p/w500
//// https://image.tmdb.org/t/p/w185
////https://image.tmdb.org/t/p/w1280/A6Y0m7qEe04ZTHKyYDLbnyCHNzn.jpg

//"backdrop_sizes": [
//      "w45",
//      "w92",
//      "w154",
//      "w185",
//      "w300",
//      "w500",
//      "w780",
//      "w1280",
//      "w1920",
//      "original"
//    ],
//    "logo_sizes": [
//      "w45",
//      "w92",
//      "w154",
//      "w185",
//      "w300",
//      "w500",
//      "original"
//    ],
//    "poster_sizes": [
//      "w45",
//      "w92",
//      "w154",
//      "w185",
//      "w300",
//      "w342",
//      "w500",
//      "w780",
//      "original"
//    ],
//    "profile_sizes": [
//      "w45",
//      "w92",
//      "w154",
//      "w185",
//      "h632",
//      "original"
//    ],
//    "still_sizes": [
//      "w45",
//      "w92",
//      "w154",
//      "w185",
//      "w300",
//      "original"
//    ]



