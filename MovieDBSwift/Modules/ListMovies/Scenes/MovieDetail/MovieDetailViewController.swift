//
//  MovieDetailViewController.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 29/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.text = viewModel.getMovie().title
        }
    }
    @IBOutlet private weak var dateLabel: UILabel! {
        didSet {
            self.dateLabel.text = viewModel.getMovie().releaseDate
        }
    }
    @IBOutlet private weak var movieDetailTextView: UITextView! {
        didSet {
            self.movieDetailTextView.text = viewModel.getMovie().overview
        }
    }
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton! {
        didSet {
            let favoriteImage = UIImage(named: "favorite")
            let tintedImage = favoriteImage?.withRenderingMode(.alwaysTemplate)
            
            favoriteButton.setImage(tintedImage, for: .normal)
            favoriteButton.tintColor = .white
        }
    }
    private var viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dataImage = viewModel.getMovie().image else { return }
        
        if let image = UIImage(data: dataImage) {
            self.movieImageView.image = image
        }
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
