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
        backgroundColor = .cellColor
        setupImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: MovieItemProtocol) {
        movieImage.loadImage(imageURL: item.imagePath)
     }
    
    private func setupImage() {
        movieImage.layer.masksToBounds = true
        movieImage.layer.cornerRadius = 8
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
