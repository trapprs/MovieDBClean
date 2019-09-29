//
//  GenreService.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 29/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

protocol GenreServiceLogic {
    func getovieGenre(ids: [Int], completion: @escaping(Result<[Genre], Error>) -> Void)
}

class GenreService: GenreServiceLogic {
    func getovieGenre(ids: [Int], completion: @escaping(Result<[Genre], Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "Genres", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GenreResult.self, from: data)
                var genres: [Genre] = []
                
                for genre in jsonData.genres {
                    for id in ids {
                        if genre.id == id {
                            genres.append(genre)
                        }
                    }
                    
                }
                completion(Result.success(genres))
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            completion(Result.failure(NSError(domain: "", code: -1, userInfo: [:])))
        }
    }
}
