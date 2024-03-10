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
    
    init(viewModel: CastDetailsViewModel) {
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
        cell.configure(cast: viewModel.castDetails)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
