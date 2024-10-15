//
//  MovieListDetailViewController.swift
//  MoviesRanking
//
//  Created by Estefania Sassone on 13/10/2024.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    private let movie: Movie
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let ratingLabel = UILabel()
    private let overviewLabel = UILabel()
    private let imageContainerView = UIView()
    private let navigationBar = NavBar(title: "Movie Detail")
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Color0")
        setupNavigationBar()
        setupScrollView()
        setupViews()
        configure(with: movie)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.overrideUserInterfaceStyle = .light
            }
        }
        navigationBar.setBackButtonVisible(true)
        navigationBar.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        let statusBarView = UIView()
        statusBarView.backgroundColor = UIColor(named: "GreenIntense")
        view.addSubview(statusBarView)
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
            
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let statusBarManager = windowScene.statusBarManager {
            let statusBarHeight = statusBarManager.statusBarFrame.height
            
            NSLayoutConstraint.activate([
                statusBarView.topAnchor.constraint(equalTo: view.topAnchor),
                statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                statusBarView.heightAnchor.constraint(equalToConstant: statusBarHeight)
            ])
        }
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
            
            //agrega el contenedor al scrollView
            scrollView.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
    }

    
    private func setupViews() {
        titleLabel.font = UIFont(name: "SourceSans3-Bold", size: 25) ?? UIFont.boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 0 //multiples lineas
        titleLabel.textColor = UIColor(named: "GreenMedium")
        
        releaseDateLabel.font = UIFont(name: "SourceSans3-Bold", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
        releaseDateLabel.textColor = UIColor(named: "GreenMedium")
        ratingLabel.font = UIFont(name: "SourceSans3-Regular", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
        ratingLabel.textColor = UIColor(named: "GreenIntense")
        overviewLabel.font = UIFont(name: "SourceSans3-Regular", size: 16)
        overviewLabel.numberOfLines = 0
        
        contentView.addSubview(imageContainerView)
        imageContainerView.addSubview(posterImageView)
        imageContainerView.addSubview(titleLabel)
        
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(overviewLabel)
        
        imageContainerView.backgroundColor = UIColor(named: "Color400")
        imageContainerView.layer.cornerRadius = 10
        imageContainerView.clipsToBounds = true
        
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        posterImageView.contentMode = .scaleAspectFit //mantiene la relacion de aspecto
        
        let constraints = [
            imageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            

            posterImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10),

            titleLabel.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: imageContainerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: imageContainerView.trailingAnchor, constant: -20),

            releaseDateLabel.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 20),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            ratingLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            overviewLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)//activa todas las constraints a la vez
    }
    
    private func configure(with movie: Movie) {
        titleLabel.text = movie.title
        releaseDateLabel.text = "Release Date: \(movie.releaseDate)"
        ratingLabel.text = "Rating: \(movie.voteAverage)"
        overviewLabel.text = movie.overview
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    print("Error loading image: \(error)")
                    return
                }
                guard let data = data, let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                    
                    let aspectRatio = image.size.height / image.size.width //modifica la altura del poster segun el aspect view
                    self?.posterImageView.heightAnchor.constraint(equalTo: self!.imageContainerView.widthAnchor, multiplier: aspectRatio).isActive = true
                    self?.imageContainerView.layoutIfNeeded()
                }
            }
            task.resume()
        }
    }
}
