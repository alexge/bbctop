//
//  HeadlineDetailController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

final class HeadlineDetailController: HeadlineDetailViewControllerDelegate {
    
    let viewController: HeadlineDetailViewController
    private let favoritesManager: FavoritesManageable
    private let story: Story
        
    init(story: Story, favoritesManager: FavoritesManageable = FavoritesManager()) {
        guard let viewController: HeadlineDetailViewController = Storyboards.headlines.viewController(scene: HeadlinesStoryboardScenes.headlineDetail) else {
            self.viewController = HeadlineDetailViewController()
            self.favoritesManager = favoritesManager
            self.story = story
            return
        }
        self.viewController = viewController
        self.favoritesManager = favoritesManager
        self.story = story
        
        self.viewController.delegate = self
        
        viewController.story = story
        viewController.isFavorite = isFavorite
    }
    
    private var isFavorite: Bool {
        return favoritesManager.isFavorite(story: story)
    }
    
    func didTapFavoritesButton() {
        _ = favoritesManager.setFavoriteStatus(story: story, favorite: !isFavorite)
        viewController.isFavorite = isFavorite
    }
}
