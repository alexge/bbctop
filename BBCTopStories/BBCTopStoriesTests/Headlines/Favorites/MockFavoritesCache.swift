//
//  MockFavoritesCache.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import Foundation

class MockFavoritesCache: FavoritesCacher {
    var favoritesList = [String]()
    var disk = [Story]()
    var defaultReturnValue: Bool = true
    
    func loadFavorites() -> [String]? {
        if defaultReturnValue {
            return favoritesList
        } else {
            return nil
        }
    }
    
    func createFavorites() -> Bool {
        return true
    }
    
    func saveToDisk(story: Story) -> Bool {
        if defaultReturnValue {
            favoritesList.append(story.headline)
            disk.append(story)
            return true
        } else {
            return false
        }
    }
    
    func removeFromDisk(story: Story) -> Bool {
        if defaultReturnValue {
            favoritesList.remove(at: favoritesList.firstIndex(where: { $0 == story.headline })!)
            disk.remove(at: disk.firstIndex(where: { $0.date == story.date })!)
            return true
        } else {
            return false
        }
    }
    
    func loadAllFromDisk() -> [Story]? {
        if defaultReturnValue {
            return disk
        } else {
            return nil
        }
    }
    
//    func clearList() {
//        favoritesList = []
//    }
//    
//    func clearDisk() {
//        disk = []
//    }
}
