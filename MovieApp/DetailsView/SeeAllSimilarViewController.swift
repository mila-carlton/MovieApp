//
//  SeeAllSimilarViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 10.03.24.
//

import UIKit

final class SeeAllSimilarViewController: UIViewController {
    
    private lazy var allSimilarCollectionView: UICollectionView = {
        
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
    
    private var similar: [MovieListResult] = []
    
    init(similar: [MovieListResult]) {
        self.similar = similar
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        
    }
    
    private func setupLayouts() {
                
        NSLayoutConstraint.activate([
            allSimilarCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            allSimilarCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allSimilarCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allSimilarCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension SeeAllSimilarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as! MovieCollectionViewCell
        
        cell.configure(item: similar[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVM = DetailsViewModel(movieId: similar[indexPath.item].id ?? 0)
        
        let detailsVc = DetailsViewController(viewModel: detailsVM)
        
        self.navigationController?.pushViewController(detailsVc, animated: true)
    }
    
}
    
