//
//  Array+SceneRepresentable.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

extension Array where Element == SceneRepresentable {
    func contains(_ scene: SceneRepresentable) -> Bool {
        return !(filter {
            $0.identifier == scene.identifier
            }.isEmpty)
    }
}
