//
//  HomeViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    
    lazy var movieTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = 280
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.id)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        return tableView
    }()
    
    
    
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
        
    }
    
    func fetchMovies() {
        
        self.viewModel.fetchTrendMovie {
            self.viewModel.fetchPopularMovies {
                self.viewModel.fetchNowPlayingMovie {
                    self.viewModel.fetchTopRatedMovie {
                        DispatchQueue.main.async {
                            self.movieTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.id , for: indexPath) as! MoviesTableViewCell
        cell.configure(movie: viewModel.cellForRowAt(index: indexPath.row))
        return cell
    }
    
    
}
