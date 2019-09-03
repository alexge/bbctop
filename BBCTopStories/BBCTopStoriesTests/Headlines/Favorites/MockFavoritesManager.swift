//
//  MockFavoritesManager.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import Foundation

class MockFavoritesManager: FavoritesManageable {
    
    private var isFavorite: Bool
    private var favorites = [Story]()
    
    init(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }

    func isFavorite(story: Story) -> Bool {
        return isFavorite
    }
    
    func setFavoriteStatus(story: Story, favorite: Bool) -> Bool {
        if favorite {
            favorites.append(story)
        } else {
            favorites.removeAll(where: { $0.date == story.date })
        }
        isFavorite = !isFavorite
        return true
    }
    
    func loadFavorites() -> [Story]? {
        return favorites
    }
    
}
