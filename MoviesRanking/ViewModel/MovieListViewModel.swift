//
//  MovieListViewModel.swift
//  MoviesRanking
//
//  Created by Estefania Sassone on 13/10/2024.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var filteredMovies: [Movie] = []
    @Published var searchQuery: String = ""{
        didSet {
            filterMovies()
        }
    }
    @Published var errorMessage: String = ""
    
    private let movieService = MovieService()
    private var cancellables = Set<AnyCancellable>()

    func fetchTopRatedMovies(completion: (()->Void)? = nil) {
        movieService.fetchTopRatedMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                    self?.filterMovies() //aplica el filtro inicial
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                completion?()
            }
        }
    }
    
    //filterMovies se llama cada vez que searchQuery cambia debido a la propiedad didSet
    func filterMovies() {
        if searchQuery.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { movie in
                movie.title.lowercased().contains(searchQuery.lowercased())
            }
        }
    }
}

