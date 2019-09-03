//
//  HeadlinesFlowControllerTests.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 02/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import XCTest

class HeadlinesFlowControllerTests: XCTestCase {

    func testInitialViewController_ShouldBeListViewController() {
        // Arrange
        let flowController = HeadlinesFlowController()
        
        // Act Arrange
        XCTAssertNotNil(flowController.initialViewController() as? HeadlinesListViewController)
    }
    
    func testListDidTapRow_ShouldPushDetailViewController() {
        // Arrange
        let nav = UINavigationController()
        let flowController = HeadlinesFlowController()
        nav.setViewControllers([flowController.initialViewController()], animated: false)
        let listController = flowController.exposedListController.exposedList
        let successExpectation = expectation(description: "success")
        
        // Act
        listController.delegate?.headlinesList(listController, didSelectHeadline: Story())
        
        // Assert
        DispatchQueue.main.async {
            if let _ = nav.topViewController as? HeadlineDetailViewController {
                successExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
}
