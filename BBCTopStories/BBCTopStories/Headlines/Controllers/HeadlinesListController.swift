//
//  HeadlinesListController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

protocol HeadlinesControllerDelegate: class {
    func headlinesList(_ headlinesList: HeadlinesListViewController, didSelectHeadline story: Story)
    func headlinesListDidTapFavoritesButton(_ headlinesList: HeadlinesListViewController)
}

final class HeadlinesListController: NSObject {
    
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
    
    weak var delegate: HeadlinesControllerDelegate?
    
    init(requestPerformer: RequestPerformable = RequestPerformer(sourceString: AppSource.current.sourceString)) {
        guard let viewController: HeadlinesListViewController = Storyboards.headlines.viewController(scene: HeadlinesStoryboardScenes.headlinesList) else {
            listViewController = HeadlinesListViewController()
            self.requestPerformer = requestPerformer
            super.init()
            return
        }
        listViewController = viewController
        self.requestPerformer = requestPerformer
        
        super.init()
        
        listViewController.delegate = self
        loadNextPage()
    }
    
    func viewController() -> HeadlinesListViewController {
        return listViewController
    }
    
    private func loadNextPage() {
        guard isLoading == false else { return }
        isLoading = true
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.requestPerformer.fetchTopStories(page: strongSelf.currentPage + 1) { stories in
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

extension HeadlinesListController: HeadlinesListViewControllerDelegate {
    func headlinesListDidReachBottom(_ headlinesList: HeadlinesListViewController) {
        loadNextPage()
    }
    
    func headlinesList(_ headlinesList: HeadlinesListViewController, didSelectHeadline story: Story) {
        delegate?.headlinesList(headlinesList, didSelectHeadline: story)
    }
    
    func headlinesListDidTapFavoritesButton(_ headlinesList: HeadlinesListViewController) {
        delegate?.headlinesListDidTapFavoritesButton(headlinesList)
    }
    
    func headlinesListWillAppear(_ headlinesList: HeadlinesListViewController) {}
}

#if DEBUG
extension HeadlinesListController {
    var exposedList: HeadlinesListViewController {
        return listViewController
    }
}
#endif
