//
//  MockURLSession.swift
//  BBCTopStoriesTests
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    private var object: Any?
    
    init(objectToReturnAsData object: Any?) {
        self.object = object
        super.init()
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockDataTask { [weak self] in
            if let object = self?.object {
                do {
                    let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
                    completionHandler(data, nil, nil)
                } catch {
                    completionHandler(nil, nil, nil)
                }
            } else {
                completionHandler(nil, nil, nil)
            }
        }
    }
}

class MockDataTask: URLSessionDataTask {
    let handler: () -> Void
    
    init(handler: @escaping () -> Void) {
        self.handler = handler
    }
    
    override func resume() {
        handler()
    }
}
