//
//  HeadlineDetailControllerTests.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import XCTest

class HeadlineDetailControllerTests: XCTestCase {

    func testToggleFavoritesToTrue_ShouldUpdateView() {
        // Arrange
        let controller = HeadlineDetailController(story: Story(), favoritesManager: MockFavoritesManager(isFavorite: false))
        let successExpectation = expectation(description: "success")
        
        // Act
        controller.didTapFavoritesButton()
        
        // Assert
        DispatchQueue.main.async {
            if controller.viewController.exposedFavoritesButton.titleLabel?.text == "Remove from Favorites" {
                successExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 1)
    }
    
    func testToggleFavoritesToFalse_ShouldUpdateView() {
        // Arrange
        let controller = HeadlineDetailController(story: Story(), favoritesManager: MockFavoritesManager(isFavorite: true))
        let successExpectation = expectation(description: "success")
        
        // Act
        controller.didTapFavoritesButton()
        
        // Assert
        DispatchQueue.main.async {
            if controller.viewController.exposedFavoritesButton.titleLabel?.text == "Save to Favorites" {
                successExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 1)
    }
}
