//
//  AppDelegate.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 15/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let listMovieFlow: RouterActionProtocol = ListMovieFlow()
        let router = RouterModules(routerModule: listMovieFlow)
        router.start()
        
        return true
    }
}

