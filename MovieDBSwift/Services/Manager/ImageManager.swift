//
//  ImageManager.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 30/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//


import Foundation

enum ImageManager {
    case image(String)
}

extension ImageManager: EndPoint {
    var query: String {
        switch self {
        case .image(let image):
            return "\(image)"
        }
    }
    
    var base: String {
        return " https://image.tmdb.org"
    }
    
    var path: String {
        switch self {
        case .image(_):
            return "/t/p/w185/"
        }
    }
}
