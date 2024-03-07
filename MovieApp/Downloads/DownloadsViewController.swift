//
//  DownloadsViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import UIKit
import AVKit
import AVFoundation

final class DownloadsViewController: UIViewController {
    
    private lazy var savedMovieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.92, height: 44)
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SavedMovieCollectionViewCell.self, forCellWithReuseIdentifier: SavedMovieCollectionViewCell.id)
        collectionView.backgroundColor = .customBackgroundColor
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let viewModel = DownloadsViewModel()
    
    var player = AVPlayer()
    var playerController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Downloads"
        autoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    func fetchMovies() {
        viewModel.getDownloadedMovies {
            DispatchQueue.main.async {
                self.savedMovieCollectionView.reloadData()
            }
        }
    }
    
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            savedMovieCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            savedMovieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            savedMovieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedMovieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension DownloadsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.savedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedMovieCollectionViewCell.id, for: indexPath) as! SavedMovieCollectionViewCell
        cell.configure(movieName: viewModel.savedMovies[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showVideo(index: indexPath.item)
    }
    
    func showVideo(index: Int) {
        let url = viewModel.savedMovies[index].filePath
        player = AVPlayer(url: URL(string: url)!)
        playerController.player = player
        self.present(playerController, animated: true) {
            self.playerController.player?.play()
        }
    }
    
    
    
}
