//
//  FavoritesCacheTests.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import XCTest

class FavoritesCacheTests: XCTestCase {
    
    override func tearDown() {
        super.tearDown()
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path.append(contentsOf: "BBCStoriesFavorites/")
        try? FileManager.default.removeItem(atPath: path)
    }

    func testCreateFavorites_ShouldCreateDirectoryAndEmptyList() {
        // Arrange
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path.append(contentsOf: "BBCStoriesFavorites/")
        try? FileManager.default.removeItem(atPath: path)
        
        // Act
        let cacher = FavoritesCache()
        let success = cacher.createFavorites()
        
        // Assert
        XCTAssertTrue(success)
        XCTAssertEqual(cacher.loadFavorites(), [String]())
    }
    
    func testSaveToDisk_ShouldReturnTrueAndUpdateListAndDisk() {
        // Arrange
        let cacher = FavoritesCache()
        _ = cacher.createFavorites()
        if let stories = cacher.loadAllFromDisk() {
            for story in stories {
                _ = cacher.removeFromDisk(story: story)
            }
        }
        let mockStory = Story()
        
        // Act
        let success = cacher.saveToDisk(story: mockStory)
        
        // Assert
        XCTAssertTrue(success)
        XCTAssertTrue(cacher.loadFavorites()!.contains(mockStory.headline))
        XCTAssertTrue(cacher.loadAllFromDisk()!.contains(where: { $0.date == mockStory.date }))
    }
    
    func testRemoveFromDisk_ShouldReturnTrueAndUpdateListAndDisk() {
        // Arrange
        let cacher = FavoritesCache()
        _ = cacher.createFavorites()
        if let stories = cacher.loadAllFromDisk() {
            for story in stories {
                _ = cacher.removeFromDisk(story: story)
            }
        }
        
        let mockStory = Story()
        _ = cacher.saveToDisk(story: mockStory)
        
        // Act
        let success = cacher.removeFromDisk(story: mockStory)
        
        // Assert
        XCTAssertTrue(success)
        XCTAssertFalse(cacher.loadFavorites()!.contains(mockStory.headline))
        XCTAssertFalse(cacher.loadAllFromDisk()!.contains(where: { $0.headline == mockStory.headline && $0.date == mockStory.date }))
    }
}
