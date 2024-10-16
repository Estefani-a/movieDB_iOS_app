//
//  MovieCell.swift
//  MoviesRanking
//
//  Created by Estefania Sassone on 13/10/2024.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    let movieImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SourceSans3-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
        
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SourceSans3-Regular", size: 14)
        label.textColor = .gray
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
            
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
                
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                
            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            releaseDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
