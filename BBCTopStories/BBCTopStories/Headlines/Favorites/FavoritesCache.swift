//
//  FavoritesCache.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 02/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

protocol FavoritesCacher: class {
    func loadFavorites() -> [String]?
    func createFavorites() -> Bool
    func saveToDisk(story: Story) -> Bool
    func removeFromDisk(story: Story) -> Bool
    func loadAllFromDisk() -> [Story]?
}

final class FavoritesCache: FavoritesCacher {
    private let directoryName = "BBCStoriesFavorites/"
    private let favoritesPath = "favoritesList"
    private let fileManager = FileManager.default
    
    func loadFavorites() -> [String]? {
        var path = cachePath()
        path.append(contentsOf: favoritesPath)
        guard let data = fileManager.contents(atPath: path) else { return nil }
        return try? JSONDecoder().decode([String].self, from: data)
    }
    
    func createFavorites() -> Bool {
        let path = cachePath()
        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            return update(favoritesList: [])
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    private func cachePath() -> String {
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path.append(contentsOf: directoryName)
        return path
    }
    
    private func update(favoritesList: [String]) -> Bool {
        var path = cachePath()
        path.append(contentsOf: favoritesPath)
        try? fileManager.removeItem(atPath: path)
        return fileManager.createFile(atPath: path,
                                      contents: Data(try! JSONSerialization.data(withJSONObject: favoritesList,
                                                                          options: .prettyPrinted)),
                                      attributes: nil)
    }
    
    func saveToDisk(story: Story) -> Bool {
        guard var favorites = loadFavorites() else {
            return false
        }
        
        var path = cachePath()
        path.append(contentsOf: story.headline)
        let jsonData = try! JSONEncoder().encode(story)
        if fileManager.createFile(atPath: path, contents: jsonData, attributes: nil) {
            favorites.append(story.headline)
            return update(favoritesList: favorites)
        } else {
            return false
        }
    }
    
    func removeFromDisk(story: Story) -> Bool {
        guard var favorites = loadFavorites() else {
            return false
        }
        if !favorites.contains(story.headline) {
            return true
        }
        do {
            var path = cachePath()
            path.append(contentsOf: story.headline)
            try fileManager.removeItem(atPath: path)
            favorites.removeAll(where: { $0 == story.headline })
            return update(favoritesList: favorites)
        } catch {
            return false
        }
    }
    
    func loadAllFromDisk() -> [Story]? {
        guard let favorites = loadFavorites() else {
            return nil
        }
        
        var favoriteStories = [Story]()
        for favorite in favorites {
            var path = cachePath()
            path.append(contentsOf: favorite)
            if let data = fileManager.contents(atPath: path),
                let story = try? JSONDecoder().decode(Story.self, from: data) {

                favoriteStories.append(story)
            }
        }
        return favoriteStories
    }
}
