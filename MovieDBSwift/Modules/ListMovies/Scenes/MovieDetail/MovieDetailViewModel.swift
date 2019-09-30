//
//  MovieDetailViewModel.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 29/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

struct MovieDetailViewModel {
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getMovie() -> Movie {
        return movie
    }
}
