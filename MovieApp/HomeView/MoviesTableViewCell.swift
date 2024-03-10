//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 08.02.24.
//

import UIKit

protocol AllMovieSeeDelegate {
    func seeAllButtonTapped(movies: HomeMovies)
}

protocol MovieSelectableDelegate {
    func movieSelected(with id: Int)
}

final class MoviesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    static let id = "\(MoviesTableViewCell.self)"
    
    private let titleLabel = UILabel()
    
    lazy var seeButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        contentView.addSubview(button)
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
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView)
        return collectionView
    }()
    
    var movies: HomeMovies?
    var movieArray: [MovieListResult] = []
    
    var seeAllMovieesDelegate: AllMovieSeeDelegate?
    var selectedMovieDelegate: MovieSelectableDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .cellColor
        setupAutoLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movie: HomeMovies) {
        titleLabel.text = movie.title
        self.movies = movie
        movieArray = movie.movieList
        
        seeButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            movieCollectionView.reloadData()
        }
    }
    @objc func seeAllButtonTapped() {
        
        guard let seeAllMovieesDelegate = self.seeAllMovieesDelegate, let movies = self.movies else { return }
        seeAllMovieesDelegate.seeAllButtonTapped(movies: movies)
    }
    
    private func  setupAutoLayouts() {
        contentView.addSubview(titleLabel)
        [titleLabel, seeButton, movieCollectionView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            seeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            seeButton.heightAnchor.constraint(equalToConstant: 14),
            seeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            movieCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            movieCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            movieCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            
        ])
    
    }
    
}
extension MoviesTableViewCell {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       movieArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as! MovieCollectionViewCell
        cell.configure(movieItem: movieArray[indexPath.item])
        cell.backgroundColor = .cellColor
        cell.layer.cornerRadius = 15
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((UIScreen.main.bounds.size.width/2.5) - 18)
        let height: CGFloat = 220
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMovieDelegate = self.selectedMovieDelegate,
                  let movieId = movieArray[indexPath.item].id else { return }
        selectedMovieDelegate.movieSelected(with: movieId)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }


}

