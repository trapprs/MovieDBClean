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
}

protocol ListUpcomingMoviesInteractorServiceProtocol { }
protocol ListUpcomingMoviesPersistenceProtocol { }

class ListUpcomingMoviesInteractorService: ListUpcomingMoviesInteractorServiceProtocol { }
class ListUpcomingMoviesPersistence: ListUpcomingMoviesPersistenceProtocol { }

final class ListUpcomingMoviesInteractor {
    private var presenter: ListUpcomingMoviesPresenterLogic?
    private var service: ListUpcomingMoviesInteractorServiceProtocol?
    private var persistence: ListUpcomingMoviesPersistenceProtocol?
    
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
}
