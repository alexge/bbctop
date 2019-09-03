//
//  FavoriteHeadlinesControllerTests.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import XCTest

class FavoriteHeadlinesControllerTests: XCTestCase {

    func testShowFavorites_With2Favorites_ShouldSet2Favorites() {
        // Arrange
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path.append(contentsOf: "BBCStoriesFavorites/")
        try? FileManager.default.removeItem(atPath: path)
        
        let favoritesManager = MockFavoritesManager(isFavorite: true)
        favoritesManager.setFavoriteStatus(story: Story(), favorite: true)
        favoritesManager.setFavoriteStatus(story: Story(), favorite: true)
        
        // Act
        let controller = FavoriteHeadlinesController(favoritesManager: favoritesManager)
        
        // Assert
        XCTAssertTrue(controller.exposedList.stories.count == 2)
    }
}
