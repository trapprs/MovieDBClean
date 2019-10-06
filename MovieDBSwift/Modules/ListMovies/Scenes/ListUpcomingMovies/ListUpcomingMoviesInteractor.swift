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
    func getImage(with movie: Movie, completion: @escaping (Result<Data, Error>) -> Void)
}

final class ListUpcomingMoviesInteractor: ListUpcomingMoviesBusinessLogic {
    private var presenter: ListUpcomingMoviesPresenterLogic?
    private var service: ListUpcomingMoviesInteractorServiceProtocol?
    private var genreService: GenreServiceLogic?
    private var movieResult: MovieFeedResult?
    
    // MARK: - Initialization
    init(with service: ListUpcomingMoviesInteractorServiceProtocol,
              genreService: GenreServiceLogic?) {
        self.service = service
        self.genreService = genreService
    }
    
    func set(presenter: ListUpcomingMoviesPresenterLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Functions
    func getListUpcomingMovies() {
        service?.getUpcomingMovies(page: 1, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.movieResult = data
                if let movieResult = self.movieResult {
                    self.presenter?.getResultToPresent(dataResult: self.setNew(movieResult: movieResult))
                }
            case .failure(let error):
                self.presenter?.getErrorFromServer(error: error)
            }
        })
    }
    
    func getImage(with movie: Movie, completion: @escaping (Result<Data, Error>) -> Void) {
        ImageOwnerRepo().requestImage(movie.posterPath, completion: { result in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(_):
                break
            }
        })
    }
    
    // MARK: - Private Functions
    private func defineGenreFor(movieResult: MovieFeedResult) -> MovieFeedResult {
        var result = movieResult
        for (index, movie) in movieResult.results.enumerated() {
            result.results[index].overview = self.defineOverview(overview: movie.overview)
            self.getGenre(genreIds: movie.genreIds) { gen in
                result.results[index].genres = gen
            }
        }
        return result
    }
    
    private func setNew(movieResult: MovieFeedResult) -> MovieFeedResult {
        return defineGenreFor(movieResult: movieResult)
    }
    
    private func defineOverview(overview: String?) -> String {
        guard let overview = overview else { return "Sem Sinópse" }
        
        return overview.isEmpty ? "Sem Sinópse" : overview
    }
    
    private func getGenre(genreIds: [Int], completion: @escaping([Genre]) -> Void) {
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
