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
    
    enum StoryDecodeError: Error {
        case invalidDateString
    }
    
    init(from aDecoder: Decoder) throws {
        let keyedContainer = try aDecoder.container(keyedBy: Story.CodingKeys.self)
        headline = try keyedContainer.decode(String.self, forKey: .headline)
        let dateString = try keyedContainer.decode(String.self, forKey: .date)
        guard let publishDate = Story.dateFormatter.date(from: dateString) else {
            throw StoryDecodeError.invalidDateString
        }
        date = publishDate
        imageURL = try keyedContainer.decode(URL.self, forKey: .imageURL)
        description = try keyedContainer.decode(String.self, forKey: .description)
        content = try keyedContainer.decodeIfPresent(String.self, forKey: .content)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Story.CodingKeys.self)
        try container.encode(headline, forKey: .headline)
        try container.encode(Story.dateFormatter.string(from: date), forKey: .date)
        try container.encode(imageURL.absoluteString, forKey: .imageURL)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(content, forKey: .content)
    }
    
    #if DEBUG
    init() {
        self.headline = "title"
        self.description = "description"
        let dateString = Story.dateFormatter.string(from: Date())
        self.date = Story.dateFormatter.date(from: dateString)!
        self.imageURL = URL(string: "wwww.google.com")!
        self.content = "content"
    }
    #endif
}
