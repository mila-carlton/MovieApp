//
//  SoonCollectionViewCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 13.02.24.
//

import UIKit

final class SoonCollectionViewCell: UICollectionViewCell {
    
    private var soonMovies: [SoonMovie] = []
    
    static let id = "\(SoonCollectionViewCell.self)"
    
    private lazy var starImage: UIImageView = {
        let starImage = UIImageView()
        starImage.image = UIImage(systemName: "star.fill")
        starImage.tintColor = .yellow
        starImage.contentMode = .scaleToFill
        addSubview(starImage)
        return starImage
    }()
    
    private lazy var soonImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        addSubview(image)
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        addSubview(label)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        addSubview(label)
        return label
    }()
    
    private lazy var rangeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movie: SoonMovie) {
        nameLabel.text = movie.originalTitle
        dateLabel.text = movie.releaseDate
        rangeLabel.text = movie.voteAverage?.rounding()
        
        soonImage.loadImage(imageURL: movie.posterPath ?? "")
    }
    
    private func setupAutoLayout() {
        
        [starImage, soonImage, nameLabel, dateLabel, rangeLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            soonImage.widthAnchor.constraint(equalToConstant: 110),
            soonImage.topAnchor.constraint(equalTo: topAnchor),
            soonImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            soonImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: soonImage.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: soonImage.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            starImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            starImage.leadingAnchor.constraint(equalTo: soonImage.trailingAnchor, constant: 8),
            starImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            starImage.widthAnchor.constraint(equalToConstant: 21),
            
            rangeLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 8),
            rangeLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor),
            rangeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            
            ])
    }
}
