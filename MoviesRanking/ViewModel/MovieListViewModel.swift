//
//  MovieListViewModel.swift
//  MoviesRanking
//
//  Created by Estefania Sassone on 13/10/2024.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject { //MovieListViewModel conforma el protocolo ObservableObject, lo que significa que puede ser observada por las vistas de SwiftUI.
    @Published var movies: [Movie] = []//cualquier cambio en estas propiedades emitirá un evento a cualquier suscriptor 
    @Published var filteredMovies: [Movie] = []
    @Published var searchQuery: String = ""{
        didSet {
            filterMovies()//llama a filterMovies cada vez que searchQuery cambia
        }
    }
    @Published var errorMessage: String = ""
    
    private let movieService = MovieService()
    private var cancellables = Set<AnyCancellable>() //conjunto que se utiliza para almacenar las suscripciones a publishers de Combine

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

