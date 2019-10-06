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
    func showMovieResult(viewModel: ListMoviesViewModel)
}

final class ListUpcomingMoviesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            let nib = UINib.init(nibName: MovieTableViewCell.reuseID,
                                 bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.reuseID)
        }
    }
    private var interactor: ListUpcomingMoviesBusinessLogic?
    private var router: Router
    private var viewModel: ListMoviesViewModel = ListMoviesViewModel(movies: [])
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - ListUpcomingMoviesDisplay
extension ListUpcomingMoviesViewController: ListUpcomingMoviesDisplay {
    func set(interactor: ListUpcomingMoviesBusinessLogic) {
        self.interactor = interactor
    }
    
    func showMovieResult(viewModel: ListMoviesViewModel) {
        self.viewModel = viewModel
    
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ListUpcomingMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.openNextViewController(with: ListMovieFlow.Scenes.getMovieDetail(viewModel.getMovies()[indexPath.row]))
    }
}

// MARK: - UITableViewDataSource
extension ListUpcomingMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMovies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseID, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let mo = viewModel.getMovies()[indexPath.row]
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.setImageToViewModel(movie: mo)
            
            DispatchQueue.main.async {
                cell.setup(movie: self.viewModel.getMovies()[indexPath.row])
            }
        }
        
        return cell
    }
    
    private func setImageToViewModel(movie: Movie) {
        self.interactor?.getImage(with: movie, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                 self.viewModel.setMovie(id: movie.id, movieData: image)
            case .failure(_):
                break
            }
        })
    }
}
