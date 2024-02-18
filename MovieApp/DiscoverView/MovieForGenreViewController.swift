//
//  MovieForGenreViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 18.02.24.
//

import UIKit

final class MovieForGenreViewController: UIViewController {
    
    private var homeMovie: [MovieListResult]!
    private let viewModel = HomeViewModel()
    
    var movies: [MovieListResult] = []
    
    var genreId: Int?
      
    lazy var genresCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(
            width: (UIScreen.main.bounds.width - 40)/3 ,
            height: 210)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        
        if let genreId = genreId {
            let moviesForGenre = homeMovie.filter { movie in
                
                if let genreIDs = movie.genreIDS {
                    return
                    genreIDs.contains(genreId)
                }
                return false
            }
            self.movies = moviesForGenre
        }
        fetchMovies()
    }
    
    func fetchMovies() {
        viewModel.fetchNowPlayingMovie {
            self.viewModel.fetchPopularMovies {
                self.viewModel.fetchTopRatedMovie {
                    self.viewModel.fetchTrendMovie {
                        DispatchQueue.main.async {
                            self.genresCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }

}
extension MovieForGenreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id , for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(movieItem: movies[indexPath.item])
        return cell
    }
    
    
}

extension MovieForGenreViewController {
    
    func setupLayouts() {
        
        NSLayoutConstraint.activate([
            genresCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            genresCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            genresCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genresCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
