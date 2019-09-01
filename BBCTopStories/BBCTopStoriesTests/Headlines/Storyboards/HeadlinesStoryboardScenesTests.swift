//
//  HeadlinesStoryboardScenesTests.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import XCTest

class HeadlinesStoryboardScenesTests: XCTestCase {

    func testHeadlinesListScene_WithHeadlinesStoryboard_ShouldInstantiateHeadlinesList() {
        // Arrange
        let scene = HeadlinesStoryboardScenes.headlinesList
        
        // Act
        let listVC: HeadlinesListViewController? = Storyboards.headlines.viewController(scene: scene)
        
        // Assert
        XCTAssertNotNil(listVC)
        XCTAssertTrue(listVC!.isViewLoaded)
    }
    
    func testInvalidScene_WithHeadlinesStoryboard_ShouldReturnNil() {
        
        // Arrange
        class InvalidScene: SceneRepresentable {
            var identifier: String = "InvalidScene"
        }
        
        // Act
        let vc = Storyboards.headlines.viewController(scene: InvalidScene())
        
        // Assert
        XCTAssertNil(vc)
    }
}
