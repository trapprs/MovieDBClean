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
    @IBOutlet private weak var movieImageView: UIImageView!
    
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
