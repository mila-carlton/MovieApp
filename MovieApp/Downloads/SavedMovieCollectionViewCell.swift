//
//  SavedMovieCollectionViewCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 07.03.24.
//

import UIKit

final class SavedMovieCollectionViewCell: UICollectionViewCell {
    
    static let id = "\(SavedMovieCollectionViewCell.self)"
    
    private lazy var movieLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cellColor
        layer.masksToBounds = true
        layer.cornerRadius = 6
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movieName: SavedMovieModel) {
        movieLabel.text = movieName.title
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            movieLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            movieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
}
