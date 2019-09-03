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
    func loadFavorites() -> [Story]?
}

final class FavoritesManager: NSObject, FavoritesManageable {
    private var favoritesList = [String]()
    
    private let cache: FavoritesCacher
    
    init(cache: FavoritesCacher = FavoritesCache()) {
        self.cache = cache
        super.init()
        loadFavoritesList()
    }
    
    func isFavorite(story: Story) -> Bool {
        return favoritesList.contains(story.headline)
    }
    
    func setFavoriteStatus(story: Story, favorite: Bool) -> Bool {
        if favorite {
            if favoritesList.contains(story.headline) {
                return true
            } else if cache.saveToDisk(story: story) {
                loadFavoritesList()
                return true
            } else {
                return false
            }
        } else {
            if !favoritesList.contains(story.headline) {
                return true
            } else if cache.removeFromDisk(story: story) {
                loadFavoritesList()
                return true
            } else {
                return false
            }
        }
    }
    
    func loadFavorites() -> [Story]? {
        return cache.loadAllFromDisk()
    }
    
    private func loadFavoritesList() {
        if let favorites = cache.loadFavorites() {
            favoritesList = favorites
        } else {
            if cache.createFavorites() {
                loadFavoritesList()
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
