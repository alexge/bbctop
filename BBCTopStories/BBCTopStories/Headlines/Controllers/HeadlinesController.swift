//
//  HeadlinesController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

final class HeadlinesController: NSObject {
    
    private let navController: UINavigationController
    private let listViewController: HeadlinesListViewController
    
    private let storyboard: UIStoryboard = UIStoryboard(name: "Headlines", bundle: .main)
    
    init(navigationController: UINavigationController) {
        navController = navigationController
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "HeadlinesListViewController") as? HeadlinesListViewController else {
            listViewController = HeadlinesListViewController()
            super.init()
            return
        }
        listViewController = viewController
        
        super.init()
        
        navController.setViewControllers([listViewController], animated: false)
        
        listViewController.title = "BBC"
    }
}
