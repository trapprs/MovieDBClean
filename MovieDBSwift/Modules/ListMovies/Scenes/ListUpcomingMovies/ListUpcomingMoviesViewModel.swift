//
//  ListUpcomingMoviesViewModel.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 29/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

struct ListMoviesViewModel {
    private var movies: [Movie] = []
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    func getMovies() -> [Movie] {
        return movies
    }
    
    mutating func setMovie(id: Int, movieData: Data) {
        for (i, _) in movies.enumerated() where id == movies[i].id {
            self.movies[i].image = movieData
        }
    }
}
