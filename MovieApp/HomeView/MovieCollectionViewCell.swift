//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 08.02.24.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    static let id = "\(MovieCollectionViewCell.self)"
    
    private let movieImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movieItem: MovieListResult) {
        movieImage.loadImage(imageURL: movieItem.posterPath ?? "")
     }
    func configure(movie: DiscoverResult) {
        movieImage.loadImage(imageURL: movie.posterPath ?? "")
    }
    func configure(searchMovie: SearchResult) {
        movieImage.loadImage(imageURL: searchMovie.posterPath ?? "")
    }
    func configure(casts: Cast) {
        movieImage.loadImage(imageURL: casts.profilePath ?? "")
    }
    func configure(similar: MovieListResult) {
        movieImage.loadImage(imageURL: similar.posterPath ?? "")
    }
    
    private func setupImage() {
        movieImage.contentMode = .scaleToFill
        addSubview(movieImage)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
