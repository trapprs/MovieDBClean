//
//  Genre.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 29/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

struct Genre: Codable {
    let id: Int
    let name: String
}

struct GenreResult: Codable {
    let genres: [Genre]
}
