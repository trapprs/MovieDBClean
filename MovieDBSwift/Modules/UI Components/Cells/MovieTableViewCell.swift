//
//  MovieTableViewCell.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 29/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.layer.cornerRadius = 10
            movieImageView.layer.shadowPath = UIBezierPath(rect: movieImageView.bounds).cgPath
        }
    }
    @IBOutlet private weak var favoriteMovieImageView: UIImageView! {
        didSet {
            let favoriteImage = UIImage(named: "favorite")
            let tintedImage = favoriteImage?.withRenderingMode(.alwaysTemplate)
            
            favoriteMovieImageView.image = tintedImage
            favoriteMovieImageView.tintColor = .orange
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DispatchQueue.main.async {
            self.movieImageView.image = UIImage()
        }
    }
    
    // MARK: - functions
   func setup(movie: Movie) {
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            self.dateLabel.text = movie.releaseDate ?? ""
            self.genderLabel.text = self.setGenreNames(movie)
            guard let dataImage = movie.image else { return }
           
            if let image = UIImage(data: dataImage) {
                self.movieImageView.image = image
            }
        }
    }
    
    private func setGenreNames(_ movie: Movie) -> String {
        var result = ""
        for genre in movie.genres {
            result += "\(genre.name); "
        }
        return result
    }
}
