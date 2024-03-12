//
//  SeeAllCastsViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 07.03.24.
//

import UIKit

final class SeeAllCastsViewController: UIViewController {
    
    var casts: [Cast] = []
    
    private lazy var allCastsCollectionView: UICollectionView = {
        
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
    
    var movieName: String
    
    init(casts: [Cast], movieName: String) {
        self.casts = casts
        self.movieName = movieName
        super.init(nibName: nil, bundle: nil)
        self.title = movieName + " Casts"
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
            allCastsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            allCastsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allCastsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allCastsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension SeeAllCastsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as! MovieCollectionViewCell
        cell.configure(casts: casts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let castVM =  CastDetailsViewModel(movieId: casts[indexPath.item].id ?? 0)
        let castVC = CastDetailsViewController(viewModel: castVM, movieName: self.movieName)
        self.navigationController?.pushViewController(castVC, animated: true)
    }
    
    
}
