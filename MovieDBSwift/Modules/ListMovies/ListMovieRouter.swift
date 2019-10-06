//
//  ListMovieRouter.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 28/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import UIKit

class ListMovieFlow: RouterActionProtocol {
    internal var moduleScenes: ModuleScenes?
    private var scene: Scenes = .listUpcomingMovies
    private var router: Router?
    private var navigation: UINavigationController?
    
    func start(router: Router) {
        self.router = router
        let view = openFirstScene()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window = window
        self.navigation = UINavigationController(rootViewController: view)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    func openViewController(in router: Router, moduleScenes: ModuleScenes) {
        self.scene = moduleScenes as? ListMovieFlow.Scenes ?? ListMovieFlow.Scenes.listUpcomingMovies
        
        switch scene {
        case .listUpcomingMovies:
            break
        case .getMovieDetail(let movie):
            let viewModel = MovieDetailViewModel(movie: movie) 
            let vc = MovieDetailViewController(viewModel: viewModel)
            self.navigation?.pushViewController(vc, animated: true)
        }
    }
    
    enum Scenes: ModuleScenes {
        case listUpcomingMovies
        case getMovieDetail(Movie)
    }
    
    private func openFirstScene() -> UIViewController {
        guard let router = self.router else { return UIViewController() }
        
        let view = ListUpcomingMoviesViewController(with: router)
        let service = ListUpcomingMoviesService()
        let interactor = ListUpcomingMoviesInteractor(with: service,
                                                      genreService: GenreService())
        view.set(interactor: interactor)
        let presenter = ListUpcomingMoviesPresenter(with: view)
        interactor.set(presenter: presenter)
        
        return view
    }
}
