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
    
    private lazy var genresCollectionView: UICollectionView = {
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
        
        collectionView.backgroundColor = .customBackgroundColor
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
    
    private lazy var searchButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        let searchItem = UIBarButtonItem(customView: button)
        return searchItem
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBackgroundColor
        navigationItem.rightBarButtonItem = searchButton
        
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.genresCollectionView.reloadData()
        }
        viewModel.fetchGenres()
    }
    
    @objc
    func searchButtonTapped() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
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
        let genreVM = MovieForGenresViewModel(id: viewModel.genre(at: indexPath.item).id ?? 0)
        let genreMoviesVC = MovieForGenreViewController(viewModelForGenre: genreVM, navigationTitle: viewModel.genre(at: indexPath.item).name ?? "")
        navigationController?.pushViewController(genreMoviesVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: (collectionView.bounds.width/2) - 16, height: 60)
    }
    
}
