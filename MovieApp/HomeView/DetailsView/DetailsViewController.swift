//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 15.02.24.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    lazy var videosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width, height: 220)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UINib(nibName: "YoutubeCell", bundle: .main), forCellWithReuseIdentifier: "YoutubeCell")
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.allowsSelection = false
        view.addSubview(collection)
        return collection
    }()
    
    lazy var movieDetailsView: MovieDetailView = {
        let detailsView = MovieDetailView()
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.backgroundColor = .systemBackground
        view.addSubview(detailsView)
        return detailsView
    }()
    
    
    var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLayout()
        getMovieDetails()
    }
    
    
    func getMovieDetails() {
        viewModel.fetchDetails {
            self.viewModel.fetchVideos {
                guard let movieDetails = self.viewModel.movieDetails else { return }
                self.movieDetailsView.configure(details: movieDetails)
                DispatchQueue.main.async {
                    self.videosCollectionView.reloadData()
                }
                print("Done")
            }
        }
    }
    
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            videosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videosCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            videosCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            videosCollectionView.heightAnchor.constraint(equalToConstant: 220),
            
            movieDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            movieDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            movieDetailsView.topAnchor.constraint(equalTo: videosCollectionView.bottomAnchor, constant: 12),
            movieDetailsView.heightAnchor.constraint(equalToConstant: 300)
        
        
        ])
    }

}


extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.videoResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YoutubeCell", for: indexPath) as! YoutubeCell
        cell.backgroundColor = .red
        cell.configure(video: viewModel.videoResults[indexPath.item])
        return cell
    }
    
}

