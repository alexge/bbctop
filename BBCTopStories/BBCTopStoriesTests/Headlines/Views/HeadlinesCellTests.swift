//
//  HeadlinesCellTests.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import XCTest

class HeadlinesCellTests: XCTestCase {

    func testDequeue_ShouldDequeueCell() {
        // Arrange
        let tableView = UITableView()
        tableView.register(HeadlinesCell.self, forCellReuseIdentifier: "HeadlinesCell")
        
        // Act
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlinesCell") as? HeadlinesCell
        
        // Assert
        XCTAssertNotNil(cell)
    }
}
