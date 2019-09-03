//
//  HeadlinesLisViewControllerTests.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import XCTest

class HeadlinesLisViewControllerTests: XCTestCase {

    func testSetFavorites_ShouldUpdateTitleAndButton() {
        // Arrange
        let vc = Storyboards.headlines.viewController(scene: HeadlinesStoryboardScenes.headlinesList) as! HeadlinesListViewController
        
        // Act
        vc.isFavoritesList = true
        
        // Assert
        XCTAssertEqual(vc.title, "Favorites")
        XCTAssertEqual(vc.exposedButton.titleLabel?.text, "Return to Top Headlines")
    }
    
    func testSetNotFavorites_ShouldUpdateTitle() {
        // Arrange
        let vc = Storyboards.headlines.viewController(scene: HeadlinesStoryboardScenes.headlinesList) as! HeadlinesListViewController
        
        // Act
        vc.isFavoritesList = false
        
        // Assert
        XCTAssertEqual(vc.title, "BBC")
        XCTAssertEqual(vc.exposedButton.titleLabel?.text, "Go to Favorites")
    }
}
