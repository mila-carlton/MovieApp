//
//  SeeAllViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 11.02.24.
//

import UIKit

final class SeeAllViewController: UIViewController {
    
    private var movies: [MovieListResult]!
    
    init(movies: HomeMovies) {
        self.movies = movies.movieList
        super.init(nibName: nil, bundle: nil)
        self.title = movies.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var allCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(
            width: (UIScreen.main.bounds.width - 40)/3 ,
            height: 210)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
    }
    
}

extension SeeAllViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as! MovieCollectionViewCell
        cell.configure(movieItem: movies[indexPath.item])
        return cell
    }
    
    
}
extension SeeAllViewController {
    
    func setupLayouts() {
                
        NSLayoutConstraint.activate([
            allCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            allCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
