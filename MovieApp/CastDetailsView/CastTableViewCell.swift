//
//  CastTableViewCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 10.03.24.
//

import UIKit

protocol FilmSelectableDelegate {
    func filmSelected(with id: Int)
}

final class CastTableViewCell: UITableViewCell {
    
    static let id = "\(CastTableViewCell.self)"
    
    private lazy var castImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var castName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
         label.numberOfLines = 7
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private lazy var starImage: UIImageView = {
         let image = UIImageView()
         image.image = UIImage(systemName: "star.fill")
         image.tintColor = .yellow
         image.contentMode = .scaleToFill
         image.translatesAutoresizingMaskIntoConstraints = false
         return image
     }()
    
    private lazy var rangeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var biographyStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Biography"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var birthPlaceStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.text = "Place of birth:"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var birthPlaceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var birthDateStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.text = "Birth date:"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var birthDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deathDateStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.text = "Death date:"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    private lazy var deathDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var filmographyStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .lightGray
        label.text = "Filmography"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeAllFilmographyButton: UIButton = {
       let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(seeAllFilmographyButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    private lazy var filmographyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: ((contentView.frame.width/2.5) - 14), height: 220)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmographyViewCell.self, forCellWithReuseIdentifier: FilmographyViewCell.id)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var seeAllFilmographyButtonTapHandler: (()->Void)?
    var selectedFilmDelegate: FilmSelectableDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addViews()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var filmographyMovies: [FilmographyCast] = []
    
    @objc
    private func seeAllFilmographyButtonPressed() {
        seeAllFilmographyButtonTapHandler?()
    }
    
    func configure(cast: CastDetailsModel, filmographyMovies: [FilmographyCast]) {
        
        DispatchQueue.main.async {
            self.filmographyMovies = filmographyMovies
            
            self.filmographyCollectionView.reloadData()
            
            self.castImage.loadImage(imageURL: cast.profilePath ?? "")
            self.castName.text = cast.name ?? ""
            self.rangeLabel.text = cast.popularity?.rounding() ?? "0.00"
            self.biographyLabel.text = cast.biography ?? "No information"
            self.birthPlaceLabel.text = cast.placeOfBirth ?? "No information"
            self.birthDateLabel.text = cast.birthday ?? "No information"
            
            if let deathday = cast.deathday, deathday != "null" {
                self.deathDateLabel.text = deathday
            } else {
                self.deathDateLabel.text = "Alive"
            }
        }
    }
    
    func addViews() {
        contentView.addSubview(castImage)
        contentView.addSubview(rangeLabel)
        contentView.addSubview(starImage)
        contentView.addSubview(castName)
        contentView.addSubview(biographyStaticLabel)
        contentView.addSubview(biographyLabel)
        contentView.addSubview(birthPlaceStaticLabel)
        contentView.addSubview(birthPlaceLabel)
        contentView.addSubview(birthDateStaticLabel)
        contentView.addSubview(birthDateLabel)
        contentView.addSubview(deathDateStaticLabel)
        contentView.addSubview(deathDateLabel)
        contentView.addSubview(filmographyStaticLabel)
        contentView.addSubview(seeAllFilmographyButton)
        contentView.addSubview(filmographyCollectionView)
        
        autoLayout()
    }
    
    private func autoLayout() {
  
        NSLayoutConstraint.activate([
            
            castImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            castImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            castImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            castImage.heightAnchor.constraint(equalToConstant: 290),
            
          
            rangeLabel.topAnchor.constraint(equalTo: castImage.bottomAnchor, constant: 17),
            rangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            rangeLabel.heightAnchor.constraint(equalToConstant: 14),
            
            starImage.trailingAnchor.constraint(equalTo: rangeLabel.leadingAnchor, constant: -4),
            starImage.centerYAnchor.constraint(equalTo: rangeLabel.centerYAnchor),
            starImage.widthAnchor.constraint(equalToConstant: 15),
            starImage.heightAnchor.constraint(equalToConstant: 15),
            
            castName.topAnchor.constraint(equalTo: castImage.bottomAnchor, constant: 12),
            castName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            castName.trailingAnchor.constraint(equalTo: starImage.leadingAnchor, constant: -8),
            castName.heightAnchor.constraint(equalToConstant: 30),
            
            biographyStaticLabel.topAnchor.constraint(equalTo: castName.bottomAnchor, constant: 16),
            biographyStaticLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            biographyStaticLabel.widthAnchor.constraint(equalToConstant: 100),
            biographyStaticLabel.heightAnchor.constraint(equalToConstant: 20),
            
            biographyLabel.topAnchor.constraint(equalTo: biographyStaticLabel.bottomAnchor, constant: 4),
            biographyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            biographyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            birthPlaceStaticLabel.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: 8),
            birthPlaceStaticLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            birthPlaceStaticLabel.heightAnchor.constraint(equalToConstant: 14),
            
            birthPlaceLabel.topAnchor.constraint(equalTo: birthPlaceStaticLabel.topAnchor),
            birthPlaceLabel.bottomAnchor.constraint(equalTo: birthPlaceStaticLabel.bottomAnchor),
            birthPlaceLabel.leadingAnchor.constraint(equalTo: birthPlaceStaticLabel.trailingAnchor, constant: 2),
            
            birthDateStaticLabel.topAnchor.constraint(equalTo: birthPlaceStaticLabel.bottomAnchor, constant: 4),
            birthDateStaticLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            birthDateStaticLabel.heightAnchor.constraint(equalToConstant: 14),
            
            birthDateLabel.topAnchor.constraint(equalTo: birthDateStaticLabel.topAnchor),
            birthDateLabel.bottomAnchor.constraint(equalTo: birthDateStaticLabel.bottomAnchor),
            birthDateLabel.leadingAnchor.constraint(equalTo: birthDateStaticLabel.trailingAnchor, constant: 2),
            
            deathDateStaticLabel.topAnchor.constraint(equalTo: birthDateStaticLabel.bottomAnchor, constant: 4),
           
            deathDateStaticLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            deathDateStaticLabel.widthAnchor.constraint(equalToConstant: 80),
            deathDateStaticLabel.heightAnchor.constraint(equalToConstant: 12),
            
            deathDateLabel.topAnchor.constraint(equalTo: deathDateStaticLabel.topAnchor),
            deathDateLabel.bottomAnchor.constraint(equalTo: deathDateStaticLabel.bottomAnchor),
            deathDateLabel.leadingAnchor.constraint(equalTo: deathDateStaticLabel.trailingAnchor, constant: 2),
            deathDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            filmographyStaticLabel.topAnchor.constraint(equalTo: deathDateStaticLabel.bottomAnchor, constant: 16),
            filmographyStaticLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            filmographyStaticLabel.widthAnchor.constraint(equalToConstant: 150),
            
            seeAllFilmographyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            seeAllFilmographyButton.centerYAnchor.constraint(equalTo: filmographyStaticLabel.centerYAnchor),
            seeAllFilmographyButton.widthAnchor.constraint(equalToConstant: 80),
            
            filmographyCollectionView.topAnchor.constraint(equalTo: filmographyStaticLabel.bottomAnchor),
            filmographyCollectionView.heightAnchor.constraint(equalToConstant: 220),
            filmographyCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            filmographyCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            filmographyCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28),
        ])
    }
}

extension CastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filmographyMovies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmographyViewCell.id, for: indexPath) as! FilmographyViewCell
        cell.configure(film: filmographyMovies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFilmDelegate?.filmSelected(with: filmographyMovies[indexPath.item].id ?? 0)
    }
    
    
}
