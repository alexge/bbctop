//
//  Storyboards.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

protocol SceneRepresentable {
    var identifier: String { get }
}

enum Storyboards: String, CaseIterable {
    case headlines = "Headlines"
    
    private var storyboard: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    private var scenes: [SceneRepresentable] {
        switch self {
        case .headlines:
            return HeadlinesStoryboardScenes.allCases
        }
    }
    
    // MARK: Methods
    
    func viewController<T: UIViewController>(scene: SceneRepresentable) -> T? {
        guard scenes.contains(scene),
            let viewController = self.storyboard.instantiateViewController(withIdentifier: scene.identifier) as? T
            else {
                
            return nil
        }
        
        viewController.loadViewIfNeeded()
        return viewController
    }
}
