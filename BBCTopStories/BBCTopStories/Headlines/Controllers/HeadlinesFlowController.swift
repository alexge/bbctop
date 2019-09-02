//
//  HeadlinesFlowController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 02/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class HeadlinesFlowController: HeadlinesControllerDelegate {
    
    private var headlinesController = HeadlinesController()
    
    init() {
        headlinesController.delegate = self
    }
    
    func initialViewController() -> UIViewController {
        return headlinesController.viewController()
    }
    
    func headlinesList(_ headlinesList: HeadlinesListViewController, didSelectHeadline story: Story) {
        guard let navController = headlinesList.navigationController,
            let detailVC = Storyboards.headlines.viewController(scene: HeadlinesStoryboardScenes.headlineDetail) as? HeadlineDetailViewController
            else {
                
                return
        }
        detailVC.story = story
        navController.pushViewController(detailVC, animated: true)
    }
}

#if DEBUG
extension HeadlinesFlowController {
    var exposedController: HeadlinesController {
        return headlinesController
    }
}
#endif
