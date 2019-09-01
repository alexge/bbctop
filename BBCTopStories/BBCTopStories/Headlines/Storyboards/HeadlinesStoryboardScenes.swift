//
//  HeadlinesStoryboardScenes.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

enum HeadlinesStoryboardScenes: String, SceneRepresentable, CaseIterable {
    case headlinesList
    
    var identifier: String {
        return rawValue
    }
}
