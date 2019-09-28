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
}

final class ListUpcomingMoviesViewController: UIViewController {
    private var interactor: ListUpcomingMoviesBusinessLogic?
    private var router: Router?

    init(with router: Router) {
        self.router = router
        
        super.init(nibName: "ListUpcomingMoviesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListUpcomingMoviesViewController: ListUpcomingMoviesDisplay {
    func set(interactor: ListUpcomingMoviesBusinessLogic) {
        self.interactor = interactor
    }
}
