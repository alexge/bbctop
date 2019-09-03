//
//  HeadlinesListControllerTests.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import XCTest

class HeadlinesListControllerTests: XCTestCase {

    let controller = HeadlinesListController(requestPerformer: MockRequestPerformer())
    
    func testFetchStories_ShouldUpdateView() {
        // Arrange
        
        let mockStory = Story()
        let successExpectation = expectation(description: "success")
        
        // Act
        _ = controller.exposedList.view
        controller.exposedList.exposedTableView.setNeedsLayout()
        
        // Assert
        DispatchQueue.main.async {
            let cell = self.controller.exposedList.exposedTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! HeadlinesCell
            if cell.exposedTitle == mockStory.headline {
                successExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
}
