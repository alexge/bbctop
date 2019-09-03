//
//  FavoritesManager.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 02/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

protocol FavoritesManageable: class {
    func isFavorite(story: Story) -> Bool
    func setFavoriteStatus(story: Story, favorite: Bool) -> Bool
}

class FavoritesManager: NSObject, FavoritesManageable {
    private var favoritesList = [String]()
    
    private let cache: FavoritesCacher
    
    init(cache: FavoritesCacher = FavoritesCache()) {
        self.cache = cache
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
    }
    
    private func loadFavorites() {
        if let favorites = cache.loadFavorites() {
            favoritesList = favorites
        } else {
            if cache.createFavorites() {
                loadFavorites()
            }
        }
    }
}

#if DEBUG
extension FavoritesManager {
    var exposedFavorites: [String] {
        return favoritesList
    }
}
#endif
