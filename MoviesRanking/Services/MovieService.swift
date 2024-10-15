//
//  MovieService.swift
//  MoviesRanking
//
//  Created by Estefania Sassone on 13/10/2024.
//

import Foundation

class MovieService {
    private let apiKey = "2c50d5a8f8f2858175ef108da1fc033a"
    private let baseUrl = "https://api.themoviedb.org/3"

    func fetchTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "\(baseUrl)/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}
