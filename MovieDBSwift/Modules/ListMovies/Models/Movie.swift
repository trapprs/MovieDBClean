//
//  Movie.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 28/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let id: Int
    let voteAverage: Double
    let voteCount: Int
    let posterPath: String
    var releaseDate: String?
    let overview: String?
    let imageMovieWhatched: String?
    let genreIds: [Int]
    var genres: [Genre] = []
}

enum MoviewKeyType: String, CodingKey {
    case originalTitle = "original_title"
    case originalLanguage = "original_language"
    case title = "title"
    case id = "id"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case overview = "overview"
    case imageMovieWhatched = "imageMovieWhatched"
    case genreIds = "genre_ids"
}

extension Movie {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MoviewKeyType.self)
        
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.title = try container.decode(String.self, forKey: .title)
        self.id = try container.decode(Int.self, forKey: .id)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.imageMovieWhatched = try container.decodeIfPresent(String.self, forKey: .imageMovieWhatched)
        self.genreIds = try container.decode([Int].self, forKey: .genreIds)
    }
}
