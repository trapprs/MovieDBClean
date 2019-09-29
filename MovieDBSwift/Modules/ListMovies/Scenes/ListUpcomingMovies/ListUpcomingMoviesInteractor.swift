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

protocol ListUpcomingMoviesInteractorServiceProtocol {
    func getUpcomingMovies(completion: @escaping(Result<MovieFeedResult, Error>) -> Void)
}

protocol ListUpcomingMoviesPersistenceProtocol { }

class ListUpcomingMoviesPersistence: ListUpcomingMoviesPersistenceProtocol { }

final class ListUpcomingMoviesInteractor {
    private var presenter: ListUpcomingMoviesPresenterLogic?
    private var service: ListUpcomingMoviesInteractorServiceProtocol?
    private var persistence: ListUpcomingMoviesPersistenceProtocol?
    private var movieResult: MovieFeedResult?
    
    init(with service: ListUpcomingMoviesInteractorServiceProtocol, persistence: ListUpcomingMoviesPersistenceProtocol) {
        self.service = service
        self.persistence = persistence
    }
}

// MARK: - ListUpcomingMoviesBusinessLogic
extension ListUpcomingMoviesInteractor: ListUpcomingMoviesBusinessLogic {
    func set(presenter: ListUpcomingMoviesPresenterLogic) {
        self.presenter = presenter
    }
    
    func getListUpcomingMovies() {
        service?.getUpcomingMovies(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.movieResult = data
                if let movieResult = self.movieResult {
                    self.presenter?.getResultToPresent(dataResult: movieResult)
                }
            case .failure(let error):
                self.presenter?.getErrorFromServer(error: error)
            }
        })
    }
}
