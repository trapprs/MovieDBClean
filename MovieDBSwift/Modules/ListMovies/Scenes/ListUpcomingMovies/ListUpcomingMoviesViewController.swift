//
//  ListUpcomingMoviesViewController.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 28/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import UIKit

protocol ListUpcomingMoviesDisplay: AnyObject {
    func set(interactor: ListUpcomingMoviesBusinessLogic)
    func showMovieResult(movies: [Movie])
}

final class ListUpcomingMoviesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            let nib = UINib.init(nibName: MovieTableViewCell.reuseID,
                                 bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.reuseID)
        }
    }
    private var interactor: ListUpcomingMoviesBusinessLogic?
    private var router: Router?
    private var movies: [Movie] = []
    
    // MARK: - Initialization
    init(with router: Router) {
        self.router = router
        
        super.init(nibName: "ListUpcomingMoviesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.getListUpcomingMovies()
    }
}

// MARK: - ListUpcomingMoviesDisplay
extension ListUpcomingMoviesViewController: ListUpcomingMoviesDisplay {
    func set(interactor: ListUpcomingMoviesBusinessLogic) {
        self.interactor = interactor
    }
    
    func showMovieResult(movies: [Movie]) {
        self.movies = movies
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ListUpcomingMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseID, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.setup(title: movies[indexPath.row].title,
                   date: movies[indexPath.row].releaseDate ?? "",
                   genres: movies[indexPath.row].genres,
                   image: UIImage())
        return cell
    }
}
