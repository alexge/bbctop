//
//  StoryListResponseModel.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 02/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

struct StoryListResponseModel: Codable {
    let status: String
    let articles: [Story]?
    let code: String?
    let message: String?
    
    private enum CodingKeys: String, CodingKey {
        case status
        case articles
        case code
        case message
    }
    
    init(from aDecoder: Decoder) throws {
        let keyedContainer = try aDecoder.container(keyedBy: StoryListResponseModel.CodingKeys.self)
        status = try keyedContainer.decode(String.self, forKey: .status)
        articles = try keyedContainer.decodeIfPresent([Story].self, forKey: .articles)
        code = try keyedContainer.decodeIfPresent(String.self, forKey: .code)
        message = try keyedContainer.decodeIfPresent(String.self, forKey: .message)
    }
}

