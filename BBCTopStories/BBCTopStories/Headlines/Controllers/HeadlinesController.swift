//
//  HeadlinesController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

final class HeadlinesController: NSObject {
    
    private let listViewController: HeadlinesListViewController
    
    private var requestPerformer: RequestPerformable
    private var isLoading: Bool = false
    private var currentPage: Int = 0
    private var moreResults: Bool = true {
        didSet {
            listViewController.moreResults = moreResults
        }
    }
    
    private var stories = [Story]() {
        didSet {
            listViewController.stories = stories
        }
    }
    
    init(requestPerformer: RequestPerformable = RequestPerformer()) {
        guard let viewController: HeadlinesListViewController = Storyboards.headlines.viewController(scene: HeadlinesStoryboardScenes.headlinesList) else {
            listViewController = HeadlinesListViewController()
            self.requestPerformer = requestPerformer
            super.init()
            return
        }
        listViewController = viewController
        self.requestPerformer = requestPerformer
        
        super.init()
        
        listViewController.title = "BBC"
        
        loadNextPage()
    }
    
    func initialViewController() -> UIViewController {
        return listViewController
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
                var newStories = strongSelf.stories
                newStories.append(contentsOf: stories)
                strongSelf.stories = newStories.sorted(by: { $0.date > $1.date })
                strongSelf.currentPage += 1
                strongSelf.isLoading = false
            }
        }
    }
}

extension HeadlinesController: HeadlinesListViewControllerDelegate {
    func willReachBottom() {
        loadNextPage()
    }
}
