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
         addSubview(image)
         return image
     }()
    
    private lazy var rangeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        addSubview(label)
        return label
    }()
    
    private lazy var biographyStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Biography"
        label.textColor = .lightGray
        addSubview(label)
        return label
    }()
    
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        addSubview(label)
        return label
    }()
    
    private lazy var birthPlaceStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Place of birth:"
        label.textColor = .lightGray
        addSubview(label)
        return label
    }()
    
    private lazy var birthPlaceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
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
        addSubview(label)
        return label
    }()
    
    private lazy var deathDateStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Death date:"
        label.textColor = .lightGray
        addSubview(label)
        return label
    }()
  
    private lazy var deathDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        addSubview(label)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cast: CastDetailsModel) {
        castImage.loadImage(imageURL: cast.profilePath ?? "")
        castName.text = cast.name ?? ""
        rangeLabel.text = cast.popularity?.rounding()
        biographyLabel.text = cast.biography ?? ""
        birthPlaceLabel.text = cast.placeOfBirth ?? ""
        birthDateLabel.text = cast.birthday ?? ""
        
        if let deathday = cast.deathday {
            deathDateLabel.text = deathday != "null" ? "\(deathday)" : "Alive"
        }
//            } else {
//                deathDateLabel.text = "Alive"
//            }
        
    }
    
    private func autoLayout() {
        
    }
}
