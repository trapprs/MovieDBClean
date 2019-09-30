//
//  MovieImage.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 30/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import UIKit

class ImageOwnerRepo {
    private var base: String = "https://image.tmdb.org/t/p/w185"
    func requestImage(_ url: String, completion: @escaping (Result<Data, Error>) -> Void)  {
        guard let URL = URL(string: "\(base)/\(url)") else {
            completion(.failure(APIError.requestFailed))
            return
        }
        DispatchQueue.global(qos: .userInteractive).async {
            let task = URLSession.shared.dataTask(with: URL) { url, _, error in
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = url else { return }
                
                completion(.success(data))
            }
            
            task.resume()
        }
        
    }
}
