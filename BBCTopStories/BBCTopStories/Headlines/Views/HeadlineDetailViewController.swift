//
//  HeadlineDetailViewController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 02/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Kingfisher
import UIKit

class HeadlineDetailViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    var story: Story? {
        didSet {
            if isViewLoaded {
                DispatchQueue.main.async {
                    self.configureSubviews()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if story != nil {
            configureSubviews()
        }
    }
    
    private func configureSubviews() {
        guard let story = story else { return }
        imageView.kf.setImage(with: story.imageURL)
        titleLabel.text = story.headline
        descriptionLabel.text = story.description
        contentLabel.text = story.content
    }
}
