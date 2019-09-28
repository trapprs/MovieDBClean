//
//  Router.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 28/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import UIKit

protocol ModuleScenes {}

protocol Router {
    init(routerModule: RouterActionProtocol)
    func start()
    func openNextViewController(with sceneName: ModuleScenes)
    func exitRouter()
}

protocol RouterActionProtocol {
    var moduleScenes: ModuleScenes? { get }
    func start(router: Router)
    func openViewController(in router: Router, moduleScenes: ModuleScenes)
}

final class RouterModules: Router {
    private var viewController: UIViewController?
    private var routerModule: RouterActionProtocol?
    
    init(routerModule: RouterActionProtocol) {
        self.routerModule = routerModule
    }
    
    func start() {
        routerModule?.start(router: self)
    }
    
    func openNextViewController(with sceneName: ModuleScenes) {
        routerModule?.openViewController(in: self, moduleScenes: sceneName)
    }
    
    func exitRouter() {
        
    }
}
