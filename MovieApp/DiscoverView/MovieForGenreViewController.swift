//
//  MovieForGenreViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 18.02.24.
//

import UIKit

final class MovieForGenreViewController: UIViewController {
    
    var viewModelForGenre = MovieForGenresViewModel()
      
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
        
        viewModelForGenre.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.genresCollectionView.reloadData()
        }
        
        viewModelForGenre.fetchDiscover()
    }
    

}
extension MovieForGenreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModelForGenre.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id , for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        let discoverItem = viewModelForGenre.movies[indexPath.item]
            cell.configure(movie: discoverItem)
        
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
