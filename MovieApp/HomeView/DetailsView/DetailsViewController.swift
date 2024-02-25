//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 15.02.24.
//

import UIKit
import WebKit

final class DetailsViewController: UIViewController, WKNavigationDelegate {
    
    lazy var webView: WKWebView = {
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        webView.navigationDelegate = self
        
        if let youtubeUrl = URL(string: "https://www.youtube.com/embed/\(viewModel.videoView.first?.key ?? "")") {
            let request = URLRequest(url: youtubeUrl)
            webView.load(request)
            print("Loaded")
        }
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        return webView
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
                print("Done")
            }
        }
    }
    
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            webView.heightAnchor.constraint(equalToConstant: 200),
            
            movieDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            movieDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            movieDetailsView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 12),
            movieDetailsView.heightAnchor.constraint(equalToConstant: 300)
        
        
        ])
    }

}


