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

final class ListUpcomingMoviesPresenter: ListUpcomingMoviesPresenterLogic {
    private weak var view: ListUpcomingMoviesDisplay?
    
    init(with view: ListUpcomingMoviesDisplay) {
        self.view = view
    }
    
    func getResultToPresent(dataResult: MovieFeedResult) {
        view?.showMovieResult(viewModel: ListMoviesViewModel(movies: getFormatedData(dataResult)))
    }
    
    func getErrorFromServer(error: Error) {
       print(error.localizedDescription)
    }
    
    private func getFormatedData(_ dataResult: MovieFeedResult) -> [Movie] {
        var movie = dataResult.results
        
        for (index,result) in dataResult.results.enumerated() {
            if let releaseDate = result.releaseDate {
                movie[index].releaseDate = releaseDate.dateFormated
            }
        }
        return movie
    }
}
