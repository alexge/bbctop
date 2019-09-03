//
//  MockRequestPerformer.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

@testable import BBCTopStories
import Foundation

class MockRequestPerformer: RequestPerformable {
    func fetchTopStories(page: Int, successHandler: @escaping (([Story]) -> Void)) {
        successHandler([Story(), Story(), Story(), Story(), Story(), Story(), Story(), Story(), Story(), Story()])
    }
}
