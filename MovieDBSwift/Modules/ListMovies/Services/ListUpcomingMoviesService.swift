//
//  ListUpcomingMoviesService.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 29/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

protocol ListUpcomingMoviesInteractorServiceProtocol {
    func getUpcomingMovies(page: Int, completion: @escaping(Result<MovieFeedResult, APIError>) -> Void)
}

class ListUpcomingMoviesService {
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

extension ListUpcomingMoviesService: ListUpcomingMoviesInteractorServiceProtocol {
    func getUpcomingMovies(page: Int, completion: @escaping (Result<MovieFeedResult, APIError>) -> Void) {
        
        MovieClient().getFeed(from: .upComing(page)) { result in
            switch result {
                
            case .success(let data):
                guard let data = data else { return }
                completion(Result.success(data))
            case .failure(let error):
                print(error)
            }
        }
    }
}
