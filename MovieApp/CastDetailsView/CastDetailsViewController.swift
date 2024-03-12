//
//  CastDetailsViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 10.03.24.
//

import UIKit

final class CastDetailsViewController: UIViewController {
    
    private lazy var castTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.id)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        view.addSubview(tableView)
        return tableView
    }()

    
    var viewModel: CastDetailsViewModel
    var movieName: String
    
    init(viewModel: CastDetailsViewModel, movieName: String) {
        self.viewModel = viewModel
        self.movieName = movieName
        super.init(nibName: nil, bundle: nil)
        self.title = movieName
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBackgroundColor
        autoLayout()
        viewModel.didUpdate = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.castTableView.reloadData()
            }
        }
        getCastDetails()
        getFilmography()
    }
    
    func getCastDetails() {
        viewModel.fetchCastDetails {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.castTableView.reloadData()
            }
        }
    }
    
    func getFilmography() {
        viewModel.fetchFilmography {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.castTableView.reloadData()
            }
        }
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            castTableView.topAnchor.constraint(equalTo: view.topAnchor),
            castTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            castTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            castTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
}

extension CastDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.id, for: indexPath) as! CastTableViewCell
        if let castDetails = viewModel.castDetails {
            cell.configure(cast: castDetails, filmographyMovies: viewModel.filmographyMovies ?? [])
        } else {
            print("error")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
