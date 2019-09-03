//
//  FavoritesManager.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 02/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class FavoritesManager: NSObject {
    var favoritesList = [String]()
    
    private let cache = FavoritesCache()
    
    override init() {
        super.init()
        loadFavorites()
    }
    
    func isFavorite(story: Story) -> Bool {
        return favoritesList.contains(story.headline)
    }
    
    func setFavoriteStatus(story: Story, favorite: Bool) -> Bool {
        if favorite {
            if favoritesList.contains(story.headline) {
                return true
            } else if cache.saveToDisk(story: story) {
                loadFavorites()
                return true
            } else {
                return false
            }
        } else {
            if !favoritesList.contains(story.headline) {
                return true
            } else if cache.removeFromDisk(story: story) {
                loadFavorites()
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    private func loadFavorites() {
        if let favorites = cache.loadFavorites() {
            favoritesList = favorites
        } else {
            cache.createFavorites { [weak self] created in
                guard created else { return }
                self?.loadFavorites()
            }
        }
    }
}
