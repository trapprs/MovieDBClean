//
//  ImageClient.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 30/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

class ImageClient: APIClient {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getImage(from url: ImageManager, completion: @escaping (Result<Data?, APIError>) -> Void) {
        guard let urlTypeRequest = url.request else { return }
        
        fetch(with: urlTypeRequest, decode: { json -> Data? in
            guard let dataImageRequest = json as? Data else { return nil }
            
            return dataImageRequest
        }, completion: completion)
    }
}
