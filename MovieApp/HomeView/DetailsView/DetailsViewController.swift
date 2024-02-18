//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 15.02.24.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    
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
        getMovieDetais()
    }
    
    
    func getMovieDetais() {
        viewModel.fetchDetails {
            guard let movieDetails = self.viewModel.movieDetails else { return }
            self.movieDetailsView.configure(details: movieDetails)
        }
    }
    
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            movieDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            movieDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            movieDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            movieDetailsView.heightAnchor.constraint(equalToConstant: 300)
        
        
        ])
    }

}


