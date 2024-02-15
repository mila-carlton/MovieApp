//
//  CustomDetailsView.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 15.02.24.
//

import UIKit

final class MovieDetailView: UIView {
    
    
    
    private lazy var namelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 18)
        addSubview(label)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .lightGray
        addSubview(label)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        addSubview(label)
        return label
    }()
    
    private lazy var rangeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        addSubview(label)
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        addSubview(label)
        return label
    }()
    
    private lazy var topSeparatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        addSubview(view)
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        addSubview(label)
        return label
    }()
    
    private lazy var releaseStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.text = "Release date"
        label.textColor = .lightGray
        addSubview(label)
        return label
    }()
    
    private lazy var genreStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.text = "Genre"
        label.textColor = .lightGray
        addSubview(label)
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        addSubview(label)
        return label
    }()
    
    private lazy var overviewStaticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Overview"
        label.textColor = .lightGray
        addSubview(label)
        return label
    }()
    
    
    private lazy var bottomSeparatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        addSubview(view)
        return view
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        addSubview(label)
        return label
    }()
    
    private lazy var clockImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "clock")
        image.contentMode = .scaleToFill
        addSubview(image)
        return image
    }()
    
   private lazy var starImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .yellow
        image.contentMode = .scaleToFill
        addSubview(image)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(details: MovieDetailsModel) {
        DispatchQueue.main.async {
            self.namelabel.text = details.title ?? ""
        }
    }
    
    private func setupLabels() {
        [namelabel, titleLabel, timeLabel, languageLabel, dateLabel, rangeLabel, topSeparatorLineView, releaseStaticLabel, genreStaticLabel, genreLabel, overviewStaticLabel, overviewLabel, clockImage, starImage, bottomSeparatorLineView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
            
                namelabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
                namelabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                
                titleLabel.topAnchor.constraint(equalTo: namelabel.bottomAnchor, constant: 4),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                
                clockImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                clockImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                clockImage.widthAnchor.constraint(equalToConstant: 15),
                clockImage.heightAnchor.constraint(equalToConstant: 15),
                
                timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                timeLabel.leadingAnchor.constraint(equalTo: clockImage.trailingAnchor, constant: 2),
                timeLabel.centerYAnchor.constraint(equalTo: clockImage.centerYAnchor),
                
                starImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                starImage.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 8),
                starImage.widthAnchor.constraint(equalToConstant: 15),
                starImage.heightAnchor.constraint(equalToConstant: 15),
                
                rangeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                rangeLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 4),
                rangeLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor),
                
                languageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
                languageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                
                topSeparatorLineView.topAnchor.constraint(equalTo: clockImage.bottomAnchor, constant: 8),
                topSeparatorLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                topSeparatorLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
                topSeparatorLineView.heightAnchor.constraint(equalToConstant: 2),
                
                releaseStaticLabel.topAnchor.constraint(equalTo: topSeparatorLineView.bottomAnchor, constant: 16),
                releaseStaticLabel.widthAnchor.constraint(equalToConstant: 80),
                releaseStaticLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                
                dateLabel.topAnchor.constraint(equalTo: releaseStaticLabel.bottomAnchor, constant: 12),
                dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                
                genreStaticLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
                genreStaticLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 16),
                genreStaticLabel.widthAnchor.constraint(equalToConstant: 60),
                
                genreLabel.topAnchor.constraint(equalTo: genreStaticLabel.bottomAnchor, constant: 12),
                genreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
                
                bottomSeparatorLineView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
                bottomSeparatorLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                bottomSeparatorLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
                bottomSeparatorLineView.heightAnchor.constraint(equalToConstant: 2),
                
                
                overviewStaticLabel.topAnchor.constraint(equalTo: bottomSeparatorLineView.bottomAnchor, constant: 16),
                overviewStaticLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                overviewStaticLabel.widthAnchor.constraint(equalToConstant: 60),
                
                overviewLabel.topAnchor.constraint(equalTo: overviewStaticLabel.bottomAnchor, constant: 12),
                overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
            
            ])
        }
    }
    
}
