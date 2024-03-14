//
//  SearchViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 04.03.24.
//

import UIKit

final class SearchViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    let viewModel = SearchViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var searchCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(
            width: (UIScreen.main.bounds.width - 40)/3 ,
            height: 210)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        collectionView.backgroundColor = .customBackgroundColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        return collectionView
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchVC()
        setupLayouts()
    }
    
    override func viewWillLayoutSubviews() {
        searchController.isActive = true
        searchController.searchBar.becomeFirstResponder()
    }
    
    func setupSearchVC() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else { viewModel.movies.removeAll()
            DispatchQueue.main.async {
                self.searchCollectionView.reloadData()
            }
        return }
        viewModel.getSearchMovies(query: query) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.searchCollectionView.reloadData()
            }
        }
    }
}
    extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            viewModel.movies.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id , for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            let movie = viewModel.movies[indexPath.item]
            cell.configure(searchMovie: movie)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            let detailsVM = DetailsViewModel(movieId: viewModel.movies[indexPath.item].id ?? 0)
            
            let detailsVc = DetailsViewController(viewModel: detailsVM)
            
            self.navigationController?.pushViewController(detailsVc, animated: true)
        }
    }

extension SearchViewController {
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            searchCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            searchCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
