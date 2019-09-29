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
}

extension ListUpcomingMoviesServiceMock: ListUpcomingMoviesInteractorServiceProtocol {
    func getUpcomingMovies(completion: @escaping (Result<MovieFeedResult, Error>) -> Void) {
        
        completion(Result.success(moviesMock))
    }
}
