//
//  JSONParser.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class JSONParser {
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    func stories(from json: [String:Any]) -> [Story] {
        guard let status = json["status"] as? String, status == "ok" else {
            print("error code: \(json["code"])")
            print("error message: \(json["message"])")
            return []
        }
        
        guard let storyJSONArray = json["articles"] as? [[String:Any]] else {
            return []
        }
        var storyArray = [Story]()
        
        for storyJSON in storyJSONArray {
            if let story = self.story(from: storyJSON) {
                storyArray.append(story)
            }
        }
        return storyArray
    }
    
    private func story(from json: [String:Any]) -> Story? {
        guard let title = json["title"] as? String,
            let description = json["description"] as? String,
            let imagePath = json["urlToImage"] as? String,
            let imageURL = URL(string: imagePath),
            let dateString = json["publishedAt"] as? String,
            let date = dateFormatter.date(from: dateString)
            else {
                return nil
        }
        let content = json["content"] as? String
        
        return Story(headline: title, date: date, imageURL: imageURL, description: description, content: content)
    }
}
