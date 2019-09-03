//
//  HeadlinesFlowController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 02/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class HeadlinesFlowController: HeadlinesControllerDelegate {
    
    private var headlinesController = HeadlinesListController()
    private var detailController: HeadlineDetailController?
    
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
}

#if DEBUG
extension HeadlinesFlowController {
    var exposedController: HeadlinesListController {
        return headlinesController
    }
}
#endif
