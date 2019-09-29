//
//  MovieFeedResult.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 28/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

struct MovieFeedResult: Codable {
    var totalPages: Int?
    let page: Int?
    let results: [Movie]
    
    enum KeyType: String, CodingKey {
        case totalPages = "total_pages"
        case page = "page"
        case results = "results"
    }
}
extension MovieFeedResult {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieFeedResult.KeyType.self)
        
        self.totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.results = try container.decode([Movie].self, forKey: .results)
    }
}
