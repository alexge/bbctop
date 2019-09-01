//
//  Story.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

struct Story: Codable {
    let headline: String
    let date: Date
    let imageURL: URL
    let description: String
    let content: String
}
