//
//  FavoriteHeadlinesController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

final class FavoriteHeadlinesController {
    
    let listViewController: HeadlinesListViewController
    private let favoritesManager: FavoritesManageable
    
    private var stories = [Story]() {
        didSet {
            listViewController.stories = stories
        }
    }
    
    weak var delegate: HeadlinesControllerDelegate?
    
    init(favoritesManager: FavoritesManageable = FavoritesManager()) {
        guard let viewController: HeadlinesListViewController = Storyboards.headlines.viewController(scene: HeadlinesStoryboardScenes.headlinesList) else {
            listViewController = HeadlinesListViewController()
            self.favoritesManager = favoritesManager
            return
        }
        listViewController = viewController
        listViewController.moreResults = false
        listViewController.isFavoritesList = true
        self.favoritesManager = favoritesManager
        
        listViewController.delegate = self
    }
    
    func viewController() -> HeadlinesListViewController {
        return listViewController
    }
    
    private func loadFavorites() {
        if let stories = favoritesManager.loadFavorites() {
            self.stories = stories
        }
    }
}

extension FavoriteHeadlinesController: HeadlinesListViewControllerDelegate {
    func headlinesListDidReachBottom(_ headlinesList: HeadlinesListViewController) {}
    
    func headlinesList(_ headlinesList: HeadlinesListViewController, didSelectHeadline story: Story) {
        delegate?.headlinesList(headlinesList, didSelectHeadline: story)
    }
    
    func headlinesListDidTapFavoritesButton(_ headlinesList: HeadlinesListViewController) {
        delegate?.headlinesListDidTapFavoritesButton(headlinesList)
    }
    
    func headlinesListWillAppear(_ headlinesList: HeadlinesListViewController) {
        loadFavorites()
    }
}
