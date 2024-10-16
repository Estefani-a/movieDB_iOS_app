//
//  MovieListView.swift
//  MoviesRanking
//
//  Created by Estefania Sassone on 13/10/2024.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    private var viewModel = MovieListViewModel()
    private let tableView = UITableView()
    private let navigationBar = NavBar(title: "Top Rated Movies")
    private let searchBar = SearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Color0")
        
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
        fetchMovies()
    }
    
    private func setupNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        let statusBarHeight: CGFloat
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let statusBarManager = windowScene.statusBarManager {
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = 0
        }
        
        NSLayoutConstraint.activate([
        navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: statusBarHeight),
        navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        navigationBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setDelegate(self)
            
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                searchBar.heightAnchor.constraint(equalToConstant: 44)
            ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EmptyCell")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),//pone la table debajo de la searchBar
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    //llama al ViewModel para obtener las películas
    private func fetchMovies() {
        viewModel.fetchTopRatedMovies {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredMovies.isEmpty ? 1 : viewModel.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.filteredMovies.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
                cell.textLabel?.text = "No hay películas para mostrar"
                cell.textLabel?.textAlignment = .center
                return cell
        }
        
        guard indexPath.row < viewModel.filteredMovies.count else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = viewModel.filteredMovies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.releaseDateLabel.text = movie.releaseDate
        let posterPath = movie.posterPath
        
        
        if !posterPath.isEmpty{
            let imageUrl = "https://image.tmdb.org/t/p/w500\(posterPath)"
            loadImage(from: imageUrl) { image in
                DispatchQueue.main.async {
                    cell.movieImageView.image = image ?? UIImage(named: "placeholder")
                }
            }
        } else {
            cell.movieImageView.image = UIImage(named: "placeholder")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < viewModel.filteredMovies.count else { return }
        let movie = viewModel.filteredMovies[indexPath.row]
        let detailVC = MovieDetailViewController(movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //cargar imagenes manualmente
    private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchQuery = searchText
        print("Filtered movies count: \(viewModel.filteredMovies.count)")
        tableView.reloadData() //recarga la tabla con los datos filtrados
    }
}
