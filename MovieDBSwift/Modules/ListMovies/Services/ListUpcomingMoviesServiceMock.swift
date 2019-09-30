//
//  ListUpcomingMoviesServiceMock.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 28/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

class ListUpcomingMoviesServiceMock {
    private let moviesMock: MovieFeedResult = MovieFeedResult(totalPages: 1, page: 1, results: [])
    
    private var genres: GenreService = GenreService()
    
    private func getGender(genreIds: [Int], completion: @escaping([Genre]) -> Void) {
        genres.getMovieGenre(ids: genreIds) { result in
            switch result {
            case .success(let genres):
                completion(genres)
            case .failure(_):
                break
            }
        }
    }
}

extension ListUpcomingMoviesServiceMock: ListUpcomingMoviesInteractorServiceProtocol {
    func getUpcomingMovies(page: Int, completion: @escaping (Result<MovieFeedResult, APIError>) -> Void) {
        if let url = Bundle.main.url(forResource: "movieResults", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                var jsonData = try decoder.decode(MovieFeedResult.self, from: data)
               
                for (index, movie) in jsonData.results.enumerated() {
                    if jsonData.results[index].overview?.isEmpty ?? false {
                       jsonData.results[index].overview = "Sem Sinópse"
                    }
                    getGender(genreIds: movie.genreIds) { gen in
                        jsonData.results[index].genres = gen
                    }
                }
                
                completion(Result.success(jsonData))
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            completion(Result.failure(.invalidData))
        }
    }
}
