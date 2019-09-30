//
//  ListUpcomingMoviesInteractor.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 28/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

protocol ListUpcomingMoviesBusinessLogic {
    func set(presenter: ListUpcomingMoviesPresenterLogic)
    func getListUpcomingMovies()
}

protocol ListUpcomingMoviesPersistenceProtocol { }

class ListUpcomingMoviesPersistence: ListUpcomingMoviesPersistenceProtocol { }

final class ListUpcomingMoviesInteractor {
    private var presenter: ListUpcomingMoviesPresenterLogic?
    private var service: ListUpcomingMoviesInteractorServiceProtocol?
    private var persistence: ListUpcomingMoviesPersistenceProtocol?
    private var genreService: GenreServiceLogic?
    private var movieResult: MovieFeedResult?
    
    init(with service: ListUpcomingMoviesInteractorServiceProtocol,
              persistence: ListUpcomingMoviesPersistenceProtocol,
              genreService: GenreServiceLogic?) {
        self.service = service
        self.persistence = persistence
        self.genreService = genreService
    }
    
    private func defineOverview(overview: String?) -> String {
        guard let overview = overview else { return "Sem Sinópse" }
        
        return overview.isEmpty ? "Sem Sinópse" : overview
    }
    
    private func getGender(genreIds: [Int], completion: @escaping([Genre]) -> Void) {
        genreService?.getMovieGenre(ids: genreIds) { result in
            switch result {
            case .success(let genres):
                completion(genres)
            case .failure(_):
                break
            }
        }
    }
}

// MARK: - ListUpcomingMoviesBusinessLogic
extension ListUpcomingMoviesInteractor: ListUpcomingMoviesBusinessLogic {
    func set(presenter: ListUpcomingMoviesPresenterLogic) {
        self.presenter = presenter
    }
    
    func getListUpcomingMovies() {
        service?.getUpcomingMovies(page: 1, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.movieResult = data
                if let movieResult = self.movieResult {
                    var movies = movieResult
                    for (index, movie) in movieResult.results.enumerated() {
                        movies.results[index].overview = self.defineOverview(overview: movie.overview)
                        self.getGender(genreIds: movie.genreIds) { gen in
                            movies.results[index].genres = gen
                        }
                        ImageOwnerRepo().requestImage(movie.posterPath, completion: { result in
                            switch result {
                            case .success(let image):
                                movies.results[index].image = image
                            case .failure(_):
                                break
                            }
                        })
                    }
                
                    self.presenter?.getResultToPresent(dataResult: movies)
                }
            case .failure(let error):
                self.presenter?.getErrorFromServer(error: error)
            }
        })
    }
}
