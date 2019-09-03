//
//  HeadlinesCell.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Kingfisher
import UIKit

final class HeadlinesCell: UITableViewCell {
    
    @IBOutlet private weak var headlineImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func bind(_ story: Story) {
        titleLabel.text = story.headline
        headlineImage.kf.setImage(with: story.imageURL)
    }
}

#if DEBUG
extension HeadlinesCell {
    var exposedTitle: String? {
        return titleLabel.text
    }
}
#endif
