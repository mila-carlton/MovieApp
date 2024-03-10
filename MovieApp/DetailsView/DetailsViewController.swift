//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 15.02.24.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    private lazy var baseTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieDetailsBaseTableCell.self, forCellReuseIdentifier: MovieDetailsBaseTableCell.id)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        view.addSubview(tableView)
        return tableView
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
        view.backgroundColor = .customBackgroundColor
        autoLayout()
        getMovieDetails()
        setupRightBarButton()
        
    }
    
    
    
    func getMovieDetails() {
        viewModel.fetchDetails {
            self.viewModel.fetchVideos {
                self.viewModel.fetchCast {
                    self.viewModel.fetchSimilar {
                        DispatchQueue.main.async {
                            self.baseTableView.reloadData()
                        }
                        
                    }
                }
        
            }
        }
    }
    
    private func setupRightBarButton() {
        let loadingButton = UIBarButtonItem(image: UIImage(systemName: "arrow.down.circle"), style: .plain, target: self, action:  #selector(startLoading))
        
        navigationItem.rightBarButtonItem = loadingButton
    }
    
    @objc
    private func startLoading() {
        showLoadingIndicator()
        viewModel.downloadVideo(movieTitle: viewModel.movieDetails?.title ?? "", trailerId: viewModel.videoResults.first?.key ?? "") {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.hideLoadingIndicator()
                
            })
            
            
            
        }

    }
    
    private func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
    }
    
    private func hideLoadingIndicator() {
        let checkmarkButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = checkmarkButton
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            if let tabBarController =  self.tabBarController {
                tabBarController.selectedIndex = 3
            }
            
        })
                
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            baseTableView.topAnchor.constraint(equalTo: view.topAnchor),
            baseTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baseTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsBaseTableCell.id, for: indexPath) as! MovieDetailsBaseTableCell
        
        cell.configure(videoResults: viewModel.videoResults, movieDetails: viewModel.movieDetails, movieCasts: viewModel.movieCastResults, similarMovies: viewModel.similarMovies)
        
        cell.seeAllCastButtonTapHandler = { [weak self] in
            guard let self = self else { return }
            let allVC = SeeAllCastsViewController(casts: self.viewModel.movieCastResults)
            navigationController?.pushViewController(allVC, animated: true)
            
        }
        
        cell.seeAllSimilarButtonTapHandler = { [weak self] in
            guard let self = self else { return }
            let allVC = SeeAllSimilarViewController(similar: self.viewModel.similarMovies)
            navigationController?.pushViewController(allVC, animated: true)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}


