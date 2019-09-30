//
//  MovieFeed.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 29/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

enum MovieFeed {
    case upComing(Int)
}

extension MovieFeed: EndPoint {
    var query: String {
        switch self {
        case .upComing(let page):
            return "language=pt-BR&page=\(page)"
        }
    }
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .upComing(_):
            return "/3/movie/upcoming"
        }
    }
}
