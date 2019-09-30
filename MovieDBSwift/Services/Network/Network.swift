//
//  Network.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 29/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

enum Result<data, error> where error: Error {
    case success(data)
    case failure(error)
}

protocol EndPoint {
    var base: String { get }
    var path: String { get }
    var query: String { get }
}
extension EndPoint {
    var apiKey: String {
        return "api_key=e76240db3aef944656a181aa86f1976a"
    }
    
    var urlComponents: URLComponents? {
        var components = URLComponents(string: base)
        guard components != nil  else {
            return URLComponents(string: "")
        }
        components!.path = path
        components!.query =  "\(path)&\(apiKey)"
        
        return components
    }
    
    var request: URLRequest? {
        guard let url = urlComponents?.url else {
            return nil
        }
        print(url)
        return URLRequest(url: url)
    }
}
