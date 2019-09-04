//
//  RequestPerformerTests.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import XCTest

class RequestPerformerTests: XCTestCase {
    
    let validJSON: [String:Any] = ["status":"ok",
                     "totalResults":10,
                     "articles":[
                        [
                         "author":"BBC News",
                         "title":"Hezbollah fires rockets into Israel",
                         "description":"Israel has confirmed the rocket.",
                         "url":"http://www.bbc.co.uk/news/world-middle-east-49544819",
                         "urlToImage":"https://ichef.bbci.co.uk/news/1024/branded_news/11339/production/_108575407_6decc18b-b48b-489b-8a05-2000a3a63399.jpg",
                         "publishedAt":"2019-09-01T15:17:24Z",
                         "content":"Image copyrightReutersImage caption\r\n Images have emerged purportedly showing smoke rising above Lebanon's Maroun al-Ras village after Israeli strikes\r\nThe Lebanese Shia militant group, Hezbollah, has fired several anti-tank rockets into northern Israel in re… [+890 chars]"
                        ],
                        [
                         "author":"BBC News",
                         "title":"More than 100 dead in Yemen strike, says Red Cross",
                         "description":"Houthi rebels say the strike hit a prison.",
                         "url":"http://www.bbc.co.uk/news/world-middle-east-49544559",
                         "urlToImage":"https://ichef.bbci.co.uk/news/1024/branded_news/EF49/production/_108575216_mediaitem108575215.jpg",
                         "publishedAt":"2019-09-01T14:09:04Z",
                         "content":"Image copyrightReutersImage caption\r\n Red Crescent medics next to bags containing the bodies of victims the air strike\r\nMore than 100 people have died in Yemen after the Saudi-led coalition launched a series of air strikes on a detention centre, according to … [+1494 chars]"
                        ]
                    ]
                    ]

    func testFetchStories_WithValidJson_ShouldCallHandler() {
        // Arrange
        let mockSession = MockURLSession(objectToReturnAsData: validJSON)
        let requestPerformer = RequestPerformer(urlSession: mockSession, sourceString: AppSource.bbc.sourceString)
        let successExpectation = expectation(description: "success response")
        
        // Act
        requestPerformer.fetchTopStories(page: 1) { stories in
            if stories.count == 2 {
                // Assert
                successExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.5)
    }
    
    func testFetchStories_WithoutJSONData_ShouldNotCallHandler() {
        // Arrange
        let mockSession = MockURLSession(objectToReturnAsData: nil)
        let requestPerformer = RequestPerformer(urlSession: mockSession, sourceString: AppSource.bbc.sourceString)
        let failureExpectation = expectation(description: "failure response")
        failureExpectation.isInverted = true
        
        // Act
        requestPerformer.fetchTopStories(page: 1) { stories in
            failureExpectation.fulfill()
        }
        waitForExpectations(timeout: 0.5) { (error) in
            // Assert
            XCTAssertTrue(true)
        }
    }
    
    func testFetchStories_WithInvalidJSONData_ShouldNotCallHandler() {
        // Arrange
        let mockSession = MockURLSession(objectToReturnAsData: nil)
        let requestPerformer = RequestPerformer(urlSession: mockSession, sourceString: AppSource.bbc.sourceString)
        let failureExpectation = expectation(description: "failure response")
        failureExpectation.isInverted = true
        
        // Act
        requestPerformer.fetchTopStories(page: 1) { stories in
            failureExpectation.fulfill()
        }
        waitForExpectations(timeout: 0.5) { (error) in
            // Assert
            XCTAssertTrue(true)
        }
    }
}
