//
//  FilmographyViewCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 12.03.24.
//

import UIKit

final class FilmographyViewCell: UICollectionViewCell {
    
    static let id = "\(FilmographyViewCell.self)"
    
    private lazy var filmImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(film: FilmographyCast) {
        filmImage.loadImage(imageURL: film.posterPath ?? "")
    }
    
    func setupUI() {
        NSLayoutConstraint.activate([
            filmImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            filmImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filmImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filmImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
    }
}
