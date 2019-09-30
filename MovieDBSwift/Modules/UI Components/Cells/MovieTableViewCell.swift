//
//  MovieTableViewCell.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 29/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.layer.cornerRadius = 10
            movieImageView.layer.shadowPath = UIBezierPath(rect: movieImageView.bounds).cgPath

            movieImageView.layer.shadowRadius = 10
            movieImageView.layer.shadowOffset = .zero
            movieImageView.layer.shadowOpacity = 0.1
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
    func setup(title: String, date: String, genres: [Genre], image: UIImage) {
        self.titleLabel.text = title
        self.dateLabel.text = date
        var gen = ""
        
        for genre in genres {
            gen += "\(genre.name); "
        }
        self.genderLabel.text = gen
    }
}
