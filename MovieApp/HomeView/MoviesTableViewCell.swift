//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 08.02.24.
//

import UIKit

final class MoviesTableViewCell: UITableViewCell {
    
    static let id = "\(MoviesTableViewCell.self)"
    
    private let titleLabel = UILabel()
    
    lazy var seeButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.tintColor = .red
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        addSubview(button)
        return button
    }()
    
    lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        return collectionView
    }()
    
    var movieArray: [MovieListResult] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAutoLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movie: HomeMovies) {
        titleLabel.text = movie.title
        movieArray = movie.movieList
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            movieCollectionView.reloadData()
        }
    }
    
    private func  setupAutoLayouts() {
        addSubview(titleLabel)
        [titleLabel, seeButton, movieCollectionView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            seeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            seeButton.heightAnchor.constraint(equalToConstant: 14),
            seeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            movieCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            movieCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            movieCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        
        ])
    }
    
}
extension MoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as! MovieCollectionViewCell
        cell.configure(movieItem: movieArray[indexPath.item])
        cell.backgroundColor = .cellColor
        cell.layer.cornerRadius = 10
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((UIScreen.main.bounds.size.width/3) - 18)
        let height: CGFloat = 230
        return CGSize(width: width, height: height)
    }
    
    
}

