//
//  StoryboardsTests.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import XCTest

class StoryboardsTests: XCTestCase {
    
    func testInstantiateStoryboard_WithAllStoryboards_ShouldInstantiateValidStoryboard() {
        // Arrange
        for storyboard in Storyboards.allCases {
            
            // Act
            let board = UIStoryboard(name: storyboard.rawValue, bundle: nil)
            
            // Assert
            XCTAssertNotNil(board)
        }
    }
}
