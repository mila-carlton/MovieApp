//
//  MovieDetailsBaseTableCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 01.03.24.
//

import UIKit

protocol CastSelectableDelegate {
    func castSelected(with id: Int)
}

protocol SimilarSelectableDelegate {
    func similarSelected(with id: Int)
}

final class MovieDetailsBaseTableCell: UITableViewCell {
    
    static let id = "\(MovieDetailsBaseTableCell.self)"
    
    private lazy var videosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 220)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UINib(nibName: "YoutubeCell", bundle: .main), forCellWithReuseIdentifier: "YoutubeCell")
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.allowsSelection = false
        contentView.addSubview(collection)
        return collection
    }()
    
    private lazy var movieDetailsView: MovieDetailView = {
        let detailsView = MovieDetailView()
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.backgroundColor = .systemBackground
        contentView.addSubview(detailsView)
        return detailsView
    }()
    
    
    private lazy var castsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: ((contentView.frame.width/2.5) - 18), height: 220)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.id)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        return collectionView
    }()
      
    private lazy var similarMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: ((contentView.frame.width/2.5) - 18), height: 190)
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        return collectionView
    }()
    
    private lazy var castLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        label.text = "Casts"
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        return label
    }()
    
    
    private lazy var seeAllCastButton: UIButton = {
       let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(seeAllCastButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        return button
    }()
    
    private lazy var similarLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        label.text = "Similar movies"
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var seeAllSimilarButton: UIButton = {
       let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(seeAllSimilarButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var videoResults: [VideoResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.videosCollectionView.reloadData()
            }
        }
    }
    
    private var casts: [Cast] = [] {
        didSet {
            DispatchQueue.main.async {
                self.castsCollectionView.reloadData()
            }
        }
    }
    
    private var similarMovies: [MovieListResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.similarMoviesCollectionView.reloadData()
            }
        }
    }
    
    private var movieDetails: MovieDetailsModel? {
        didSet {
            guard let movieDetails = movieDetails else { return  }
            self.movieDetailsView.configure(details: movieDetails)
        }
    }
    
    var seeAllCastButtonTapHandler: (()->Void)?
    var seeAllSimilarButtonTapHandler: (()->Void)?
    
    var selectedCastDelegate: CastSelectableDelegate?
    var selectedSimilarDelegate: SimilarSelectableDelegate?

    func configure(videoResults: [VideoResult], movieDetails: MovieDetailsModel?, movieCasts: [Cast], similarMovies: [MovieListResult]) {
        
        self.videoResults = videoResults
        self.casts = movieCasts
        self.similarMovies = similarMovies
        self.movieDetails = movieDetails
    }
    
    @objc
    func seeAllCastButtonPressed() {
        seeAllCastButtonTapHandler?()
    }
    
    @objc
    func seeAllSimilarButtonPressed() {
        seeAllSimilarButtonTapHandler?()
    }

    private func autoLayout() {
        NSLayoutConstraint.activate([
            
            videosCollectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            videosCollectionView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            videosCollectionView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            videosCollectionView.heightAnchor.constraint(equalToConstant: 220),
            
            movieDetailsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            movieDetailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            movieDetailsView.topAnchor.constraint(equalTo: videosCollectionView.bottomAnchor, constant: 12),
            movieDetailsView.heightAnchor.constraint(equalToConstant: 310),
            
            
            castLabel.topAnchor.constraint(equalTo: movieDetailsView.bottomAnchor, constant: 12),
            castLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            castLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
            castLabel.heightAnchor.constraint(equalToConstant: 20),
            
            seeAllCastButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            seeAllCastButton.centerYAnchor.constraint(equalTo: castLabel.centerYAnchor),
            seeAllCastButton.widthAnchor.constraint(equalToConstant: 80),
            
            castsCollectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 8),
            castsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            castsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            castsCollectionView.heightAnchor.constraint(equalToConstant: 220),
            
            similarLabel.topAnchor.constraint(equalTo: castsCollectionView.bottomAnchor, constant: 14),
            similarLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            similarLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            similarLabel.heightAnchor.constraint(equalToConstant: 20),
            
            seeAllSimilarButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            seeAllSimilarButton.centerYAnchor.constraint(equalTo: similarLabel.centerYAnchor),
            seeAllSimilarButton.widthAnchor.constraint(equalToConstant: 80),
        
            similarMoviesCollectionView.topAnchor.constraint(equalTo: similarLabel.bottomAnchor, constant: 8),
            similarMoviesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            similarMoviesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            similarMoviesCollectionView.heightAnchor.constraint(equalToConstant: 200),
            similarMoviesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28)
            
        ])
    }

    
}


extension MovieDetailsBaseTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == videosCollectionView {
            return videoResults.count
        } else if collectionView == castsCollectionView {
            return casts.count
        } else {
            return similarMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == videosCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YoutubeCell", for: indexPath) as! YoutubeCell
            cell.configure(video: videoResults[indexPath.item])
            return cell
            
        } else if collectionView == castsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.id, for: indexPath) as! CastCollectionViewCell
            cell.configure(casts: casts[indexPath.item])
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as! MovieCollectionViewCell
            cell.configure(movieItem: similarMovies[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == castsCollectionView {
            selectedCastDelegate?.castSelected(with: casts[indexPath.item].id ?? 0)
        } else if collectionView == similarMoviesCollectionView {
            selectedSimilarDelegate?.similarSelected(with: similarMovies[indexPath.item].id ?? 0)
        }
    }
    
}
