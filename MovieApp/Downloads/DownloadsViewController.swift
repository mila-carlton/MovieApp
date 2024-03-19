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
    
    private lazy var savedMovieCollectionView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SavedMovieTableViewCell.self, forCellReuseIdentifier: SavedMovieTableViewCell.id)
        
        tableView.backgroundColor = .customBackgroundColor
        tableView.separatorStyle = .none
        tableView.rowHeight = 54
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        return tableView
    }()
    
    private let viewModel = DownloadsViewModel()
    
    private var player = AVPlayer()
    private var playerController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Downloads"
        autoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    private func fetchMovies() {
        viewModel.getDownloadedMovies {
            DispatchQueue.main.async {
                self.savedMovieCollectionView.reloadData()
            }
        }
    }
    
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            
            savedMovieCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            savedMovieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            savedMovieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedMovieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension DownloadsViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.savedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedMovieTableViewCell.id, for: indexPath) as! SavedMovieTableViewCell
        cell.configure(movieName: viewModel.savedMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showVideo(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.viewModel.savedMovies.remove(at: indexPath.row)
            self.viewModel.deleteMovie(movieId: viewModel.savedMovies[indexPath.row].movieId) {
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
        }
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
