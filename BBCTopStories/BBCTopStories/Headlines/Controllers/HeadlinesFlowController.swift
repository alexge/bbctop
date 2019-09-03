//
//  HeadlinesFlowController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 02/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

final class HeadlinesFlowController: HeadlinesControllerDelegate {
    
    private var headlinesController = HeadlinesListController()
    private var detailController: HeadlineDetailController?
    private var favoritesController: FavoriteHeadlinesController?
    
    init() {
        headlinesController.delegate = self
    }
    
    func initialViewController() -> UIViewController {
        return headlinesController.viewController()
    }
    
    func headlinesList(_ headlinesList: HeadlinesListViewController, didSelectHeadline story: Story) {
        guard let navController = headlinesList.navigationController else { return }
        
        detailController = HeadlineDetailController(story: story)
        navController.pushViewController(detailController!.viewController, animated: true)
    }
    
    func headlinesListDidTapFavoritesButton(_ headlinesList: HeadlinesListViewController) {
        if headlinesList.isFavoritesList {
            headlinesList.dismiss(animated: true, completion: nil)
        } else {
            favoritesController = FavoriteHeadlinesController()
            favoritesController?.delegate = self
            let favoritesNavController = UINavigationController()
            favoritesNavController.setViewControllers([favoritesController!.viewController()], animated: false)
            headlinesList.present(favoritesNavController, animated: true, completion: nil)
        }
    }
}

#if DEBUG
extension HeadlinesFlowController {
    var exposedListController: HeadlinesListController {
        return headlinesController
    }
}
#endif
