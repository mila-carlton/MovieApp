//
//  SeeAllFilmographyViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 14.03.24.
//

import UIKit

final class SeeAllFilmographyViewController: UIViewController {

    var filmography: [FilmographyCast] = []
    
    private lazy var allFilmographyCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        layout.itemSize = CGSize(
            width: (UIScreen.main.bounds.width - 20)/3 ,
            height: 190)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        return collectionView
    }()
    
    init(filmography: [FilmographyCast]) {
        self.filmography = filmography
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
    }
    
    func setupLayouts() {
                
        NSLayoutConstraint.activate([
            allFilmographyCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            allFilmographyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allFilmographyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allFilmographyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension SeeAllFilmographyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filmography.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as! MovieCollectionViewCell
        cell.configure(filmography: filmography[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsVM = DetailsViewModel(movieId: filmography[indexPath.item].id ?? 0)
        
        let detailsVc = DetailsViewController(viewModel: detailsVM)
        
        self.navigationController?.pushViewController(detailsVc, animated: true)
    }

}
