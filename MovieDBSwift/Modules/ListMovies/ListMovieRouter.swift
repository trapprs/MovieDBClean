//
//  ListMovieRouter.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 28/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import UIKit

class ListMovieRouter: Router {
    internal var moduleScenes: ModuleScenes?
    private var scene: Scenes = .listMovies
    private var router: Router?
    private var navigation: UINavigationController?
    
    required init(routerModule: RouterActionProtocol) {
        
    }
    
    func start() {
        
    }
    
    func openNextViewController(with sceneName: ModuleScenes) {
        
    }
    
    func exitRouter() {
        
    }
    
    
    enum Scenes: ModuleScenes {
        case listMovies
    }
}
