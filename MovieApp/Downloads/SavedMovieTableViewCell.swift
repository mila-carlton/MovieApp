//
//  SavedMovieCollectionViewCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 07.03.24.
//

import UIKit

final class SavedMovieTableViewCell: UITableViewCell {
    
    static let id = "\(SavedMovieTableViewCell.self)"
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }()
    
    private lazy var movieLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        baseView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movieName: SavedMovieModel) {
        movieLabel.text = movieName.title
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            movieLabel.topAnchor.constraint(equalTo: baseView.topAnchor),
            movieLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            movieLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 12),
            movieLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -4)
        ])
    }
}
