//
//  ListUpcomingMoviesPresenter.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 28/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

protocol ListUpcomingMoviesPresenterLogic {
    func getResultToPresent(dataResult: MovieFeedResult)
    func getErrorFromServer(error: Error)
}

final class ListUpcomingMoviesPresenter {
    private weak var view: ListUpcomingMoviesDisplay?
    
    init(with view: ListUpcomingMoviesDisplay) {
        self.view = view
    }
}

// MARK: - ListUpcomingMoviesPresenterLogic
extension ListUpcomingMoviesPresenter: ListUpcomingMoviesPresenterLogic {
    func getResultToPresent(dataResult: MovieFeedResult) {
        var movieResult = dataResult.results
        
        for (index,result) in dataResult.results.enumerated() {
            if let releaseDate = result.releaseDate {
                movieResult[index].releaseDate = releaseDate.dateFormated
            }
        }
        
        view?.showMovieResult(movies: movieResult)
    }
    
    func getErrorFromServer(error: Error) {
        // TODO - Error handler
    }
}
