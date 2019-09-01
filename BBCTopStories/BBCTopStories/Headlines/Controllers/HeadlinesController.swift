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
    
    private var requestPerformer: RequestPerformable
    private var isLoading: Bool = false
    private var currentPage: Int = 0
    private var moreResults: Bool = true {
        didSet {
//            listViewController.moreResults = moreResults
        }
    }
    
    private var stories = [Story]()
    
    init(navigationController: UINavigationController, requestPerformer: RequestPerformable = RequestPerformer()) {
        navController = navigationController
        guard let viewController: HeadlinesListViewController = Storyboards.headlines.viewController(scene: HeadlinesStoryboardScenes.headlinesList) else {
            listViewController = HeadlinesListViewController()
            self.requestPerformer = requestPerformer
            super.init()
            return
        }
        listViewController = viewController
        self.requestPerformer = requestPerformer
        
        super.init()
        
        navController.setViewControllers([listViewController], animated: false)
        
        listViewController.title = "BBC"
        
        loadNextPage()
    }
    
    private func loadNextPage() {
        guard isLoading == false else { return }
        isLoading = true
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else { return }
            self?.requestPerformer.fetchTopStories(page: strongSelf.currentPage + 1) { stories in
                if stories.count < 20 {
                    strongSelf.moreResults = false
                }
                strongSelf.stories.append(contentsOf: stories)
                strongSelf.currentPage += 1
                strongSelf.isLoading = false
            }
        }
    }
}
