//
//  MovieForGenreViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 18.02.24.
//

import UIKit

final class MovieForGenreViewController: UIViewController {
    
    private lazy var genresCollectionView: UICollectionView = {
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
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        return collectionView
    }()
    private var viewModelForGenre = MovieForGenresViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        
        viewModelForGenre.fetchDiscover()
        
        viewModelForGenre.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.genresCollectionView.reloadData()
        }
    }
    
    init(viewModelForGenre: MovieForGenresViewModel = MovieForGenresViewModel(), navigationTitle: String) {
        self.viewModelForGenre = viewModelForGenre
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = navigationTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MovieForGenreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModelForGenre.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id , for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        let discoverItem = viewModelForGenre.movies[indexPath.item]
        cell.configure(item: discoverItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVM = DetailsViewModel(movieId: viewModelForGenre.movies[indexPath.item].id ?? 0)
        let detailsVc = DetailsViewController(viewModel: detailsVM)
        self.navigationController?.pushViewController(detailsVc, animated: true)
    }
}

extension MovieForGenreViewController {
    
    func setupLayouts() {
        view.backgroundColor = .background
        
        NSLayoutConstraint.activate([
            genresCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 8),
            genresCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            genresCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genresCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
