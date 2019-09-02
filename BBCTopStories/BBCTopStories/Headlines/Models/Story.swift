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
    let content: String?
    
    private enum CodingKeys: String, CodingKey {
        case headline = "title"
        case date = "publishedAt"
        case imageURL = "urlToImage"
        case description = "description"
        case content = "content"
    }
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    init(from aDecoder: Decoder) throws {
        let keyedContainer = try aDecoder.container(keyedBy: Story.CodingKeys.self)
        headline = try keyedContainer.decode(String.self, forKey: .headline)
        let dateString = try keyedContainer.decode(String.self, forKey: .date)
        date = Story.dateFormatter.date(from: dateString)!
        imageURL = try keyedContainer.decode(URL.self, forKey: .imageURL)
        description = try keyedContainer.decode(String.self, forKey: .description)
        content = try keyedContainer.decodeIfPresent(String.self, forKey: .content)
    }
    
    #if DEBUG
    init() {
        self.headline = "title"
        self.description = "description"
        self.date = Date()
        self.imageURL = URL(string: "wwww.google.com")!
        self.content = "content"
    }
    #endif
}
