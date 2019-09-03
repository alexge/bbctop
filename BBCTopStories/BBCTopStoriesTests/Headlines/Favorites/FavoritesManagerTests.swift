//
//  FavoritesManagerTests.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import XCTest

class FavoritesManagerTests: XCTestCase {

    func testIsFavorite_WithSavedStory_ShouldReturnTrue() {
        // Arrange
        let manager = FavoritesManager(cache: MockFavoritesCache())
        let mockStory = Story()
        
        // Act
        _ = manager.setFavoriteStatus(story: mockStory, favorite: true)
        
        // Assert
        XCTAssertTrue(manager.isFavorite(story: mockStory))
    }
    
    func testIsFavorite_WithNotSavedStory_ShouldReturnFalse() {
        // Arrange
        let manager = FavoritesManager(cache: MockFavoritesCache())
        let mockStory = Story()
        
        // Assert
        XCTAssertFalse(manager.isFavorite(story: mockStory))
    }
    
    func testSetFavorite_WithNotSavedStory_ShouldReturnTrueAndUpdateFavoritesList() {
        // Arrange
        let manager = FavoritesManager(cache: MockFavoritesCache())
        let mockStory = Story()
        
        // Act
        let success = manager.setFavoriteStatus(story: mockStory, favorite: true)
        
        // Assert
        XCTAssertTrue(success)
        XCTAssertTrue(manager.exposedFavorites[0] == mockStory.headline)
    }
    
    func testSetFavorite_WithtSavedStory_ShouldReturnTrue() {
        // Arrange
        let manager = FavoritesManager(cache: MockFavoritesCache())
        let mockStory = Story()
        
        // Act
        _ = manager.setFavoriteStatus(story: mockStory, favorite: true)
        let success = manager.setFavoriteStatus(story: mockStory, favorite: true)
        
        // Assert
        XCTAssertTrue(success)
    }
    
    func testRemoveFavorite_WithSavedStory_ShouldReturnTrue() {
        // Arrange
        let manager = FavoritesManager(cache: MockFavoritesCache())
        let mockStory = Story()
        _ = manager.setFavoriteStatus(story: mockStory, favorite: true)
        
        // Act
        let success = manager.setFavoriteStatus(story: mockStory, favorite: false)
        
        // Assert
        XCTAssertTrue(success)
        XCTAssertTrue(manager.exposedFavorites == [])
    }
    
    func testRemoveFavorite_WithNotSavedStory_ShouldReturnTrue() {
        // Arrange
        let manager = FavoritesManager(cache: MockFavoritesCache())
        let mockStory = Story()
        
        // Act
        let success = manager.setFavoriteStatus(story: mockStory, favorite: false)
        
        // Assert
        XCTAssertTrue(success)
        XCTAssertTrue(manager.exposedFavorites == [])
    }
}
