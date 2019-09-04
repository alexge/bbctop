//
//  AppSource.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 03/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

enum AppSource {
    case bbc
    case nyt
    
    static var current: AppSource {
        #if BBC
            return .bbc
        #else
            return .nyt
        #endif
    }
    
    var title: String {
        switch self {
        case .bbc:
            return "BBC"
        case .nyt:
            return "NYT"
        }
    }
    
    var cacheDirectory: String {
        switch AppSource.current {
        case .bbc:
            return "BBCStoriesFavorites/"
        case .nyt:
            return "NYCStoriesFavorites/"
        }
    }
    
    var sourceString: String {
        switch AppSource.current {
        case .bbc:
            return "bbc-news"
        case .nyt:
            return "the-new-york-times"
        }
    }
}
