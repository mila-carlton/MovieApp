//
//  DiscoverViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import UIKit

final class DiscoverViewController: UIViewController {
    
    private var viewModel = GenresViewModel()
    private var viewModelForGenre = MovieForGenresViewModel()
    
    lazy var genresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        title = "Genres"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBackgroundColor
        
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.genresCollectionView.reloadData()
        }
        viewModel.fetchGenres()
    }
    

}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfGenres()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let genre = viewModel.genre(at: indexPath.item)
        let label = UILabel(frame: cell.bounds)
        label.text = genre.name
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        cell.contentView.addSubview(label)
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .cellColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieVC = MovieForGenreViewController()
        let selectedGenreId = viewModel.genre(at: indexPath.item).id ?? 0
        movieVC.viewModelForGenre = MovieForGenresViewModel(id: selectedGenreId)
        movieVC.title = "\(viewModel.genre(at: indexPath.item).name ?? "") movies"
        
        navigationController?.pushViewController(movieVC, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: (collectionView.bounds.width/2) - 16, height: 60)
    }
    
}
