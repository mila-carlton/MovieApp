//
//  CastTableViewCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 10.03.24.
//

import UIKit

final class CastTableViewCell: UITableViewCell {
    
    static let id = "\(CastTableViewCell.self)"
    
    private lazy var castImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        return imageView
    }()
    
    private lazy var castName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
         label.numberOfLines = 1
         label.translatesAutoresizingMaskIntoConstraints = false
         contentView.addSubview(label)
         return label
    }()
    
    private lazy var starImage: UIImageView = {
         let image = UIImageView()
         image.image = UIImage(systemName: "star.fill")
         image.tintColor = .yellow
         image.contentMode = .scaleToFill
         starImage.translatesAutoresizingMaskIntoConstraints = false
         addSubview(image)
         return image
     }()
    
    private lazy var rangeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        rangeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    private lazy var biographyStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Biography"
        label.textColor = .lightGray
        biographyStaticLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        biographyLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    private lazy var birthPlaceStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Place of birth:"
        label.textColor = .lightGray
        birthPlaceStaticLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    private lazy var birthPlaceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        birthPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    private lazy var birthDateStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Birth date:"
        label.textColor = .lightGray
        addSubview(label)
        return label
    }()
    
    private lazy var birthDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        birthDateStaticLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    private lazy var deathDateStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Death date:"
        label.textColor = .lightGray
        deathDateStaticLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
  
    private lazy var deathDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        deathDateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(cast: CastDetailsModel) {
        DispatchQueue.main.async {
            self.castImage.loadImage(imageURL: cast.profilePath ?? "")
            self.castName.text = cast.name ?? ""
            self.rangeLabel.text = cast.popularity?.rounding() ?? ""
            self.biographyLabel.text = cast.biography ?? ""
            self.birthPlaceLabel.text = cast.placeOfBirth ?? ""
            self.birthDateLabel.text = cast.birthday ?? ""
            
            if let deathday = cast.deathday, deathday != "null" {
                        self.deathDateLabel.text = deathday
                    } else {
                        self.deathDateLabel.text = "Alive"
                    }
                }
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            
            castImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            castImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            castImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            castImage.heightAnchor.constraint(equalToConstant: 220),
            
            castName.topAnchor.constraint(equalTo: castImage.bottomAnchor, constant: 8),
            castName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            castName.widthAnchor.constraint(equalToConstant: 80),
            castName.heightAnchor.constraint(equalToConstant: 16),
            
            starImage.topAnchor.constraint(equalTo: castImage.bottomAnchor, constant: 8),
            starImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            starImage.widthAnchor.constraint(equalToConstant: 15),
            starImage.heightAnchor.constraint(equalToConstant: 15),
            
            rangeLabel.topAnchor.constraint(equalTo: castImage.bottomAnchor, constant: 8),
            rangeLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 2),
            rangeLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor),
            
            biographyStaticLabel.topAnchor.constraint(equalTo: castName.bottomAnchor, constant: 12),
            biographyStaticLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            biographyStaticLabel.widthAnchor.constraint(equalToConstant: 70),
            biographyStaticLabel.heightAnchor.constraint(equalToConstant: 20),
            
            biographyLabel.topAnchor.constraint(equalTo: biographyStaticLabel.bottomAnchor, constant: 4),
            biographyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            biographyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            biographyLabel.heightAnchor.constraint(equalToConstant: 400),
            
            birthPlaceStaticLabel.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: 4),
            birthDateStaticLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            birthPlaceStaticLabel.widthAnchor.constraint(equalToConstant: 40),
            
            birthPlaceLabel.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: 4),
            birthPlaceLabel.leadingAnchor.constraint(equalTo: birthPlaceStaticLabel.trailingAnchor, constant: 2),
            birthPlaceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            birthDateStaticLabel.topAnchor.constraint(equalTo: birthPlaceStaticLabel.bottomAnchor, constant: 4),
            birthDateStaticLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            birthDateStaticLabel.widthAnchor.constraint(equalToConstant: 40),
            
            birthDateLabel.topAnchor.constraint(equalTo: birthPlaceLabel.bottomAnchor, constant: 4),
            birthDateLabel.leadingAnchor.constraint(equalTo: birthDateStaticLabel.trailingAnchor, constant: 2),
            birthDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            deathDateStaticLabel.topAnchor.constraint(equalTo: birthDateStaticLabel.bottomAnchor, constant: 4),
            deathDateStaticLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            deathDateStaticLabel.widthAnchor.constraint(equalToConstant: 40),
            
            deathDateLabel.topAnchor.constraint(equalTo: birthDateLabel.bottomAnchor, constant: 4),
            deathDateLabel.leadingAnchor.constraint(equalTo: deathDateStaticLabel.trailingAnchor, constant: 2),
            deathDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        
        ])
    }
}
