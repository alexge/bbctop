//
//  HeadlineDetailViewController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 02/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Kingfisher
import UIKit

protocol HeadlineDetailViewControllerDelegate: class {
    func didTapFavoritesButton()
}

class HeadlineDetailViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var story: Story? {
        didSet {
            if isViewLoaded {
                DispatchQueue.main.async {
                    self.configureSubviews()
                }
            }
        }
    }
    
    var isFavorite: Bool = false {
        didSet {
            if isViewLoaded {
                DispatchQueue.main.async {
                    self.configureButton()
                }
            }
        }
    }
    
    weak var delegate: HeadlineDetailViewControllerDelegate?
    
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
    
    private func configureButton() {
        if isFavorite {
            favoritesButton.setTitle("Remove from Favorites", for: .normal)
            favoritesButton.isEnabled = true
        } else {
            favoritesButton.setTitle("Save to Favorites", for: .normal)
            favoritesButton.isEnabled = true
        }
    }
    
    @IBAction private func favoritesButtonTapped(_ sender: Any) {
        favoritesButton.isEnabled = false
        delegate?.didTapFavoritesButton()
    }
}

#if DEBUG
extension HeadlineDetailViewController {
    var exposedFavoritesButton: UIButton {
        return favoritesButton
    }
}
#endif
