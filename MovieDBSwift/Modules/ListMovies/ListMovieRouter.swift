//
//  ListMovieRouter.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 28/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import UIKit

class ListMovieRouter: RouterActionProtocol {
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
        
    }
    
    enum Scenes: ModuleScenes {
        case listUpcomingMovies
    }
    
    private func openFirstScene() -> UIViewController {
        guard let router = self.router else { return UIViewController() }
        
        let view = ListUpcomingMoviesViewController(with: router)
        let interactor = ListUpcomingMoviesInteractor(with: ListUpcomingMoviesInteractorService(), persistence: ListUpcomingMoviesPersistence())
        view.set(interactor: interactor)
        let presenter = ListUpcomingMoviesPresenter(with: view)
        interactor.set(presenter: presenter)
        
        return view
    }
}
