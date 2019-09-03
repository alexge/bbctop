//
//  JSONParser.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

final class JSONParser {
    
    func responseModel(from data: Data) -> StoryListResponseModel? {
        do {
            let responseModel = try JSONDecoder().decode(StoryListResponseModel.self, from: data)
            return responseModel
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
