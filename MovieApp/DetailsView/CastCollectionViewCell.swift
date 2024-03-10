//
//  CastCollectionViewCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 01.03.24.
//

import UIKit

final class CastCollectionViewCell: UICollectionViewCell {
    static let id = "\(CastCollectionViewCell.self)"

    private lazy var castImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        return imageView
        
    }()
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var roleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(casts: Cast) {
        self.castImageView.loadImage(imageURL: casts.profilePath ?? "")
        self.nameLabel.text = casts.originalName ?? ""
        self.roleLabel.text = casts.character ?? ""
    }
    
    
    private func autoLayout() {
        
        NSLayoutConstraint.activate([
            castImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            castImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castImageView.heightAnchor.constraint(equalToConstant: 180),
            
            nameLabel.topAnchor.constraint(equalTo: castImageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 14),
            
            roleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            roleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            roleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            roleLabel.heightAnchor.constraint(equalToConstant: 14),
            roleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        
        ])
    }
    
    
}
