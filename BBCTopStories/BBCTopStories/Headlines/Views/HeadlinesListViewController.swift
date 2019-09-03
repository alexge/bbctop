//
//  HeadlinesListViewController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

protocol HeadlinesListViewControllerDelegate: class {
    func headlinesListDidReachBottom(_ headlinesList: HeadlinesListViewController)
    func headlinesList(_ headlinesList: HeadlinesListViewController, didSelectHeadline story: Story)
    func headlinesListDidTapFavoritesButton(_ headlinesList: HeadlinesListViewController)
    func headlinesListWillAppear(_ headlinesList: HeadlinesListViewController)
}

final class HeadlinesListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet private weak var favoritesButton: UIButton!
    
    var stories = [Story]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var isFavoritesList: Bool = false {
        didSet {
            if isFavoritesList {
                title = "Favorites"
                favoritesButton.setTitle("Return to Top Headlines", for: .normal)
            } else {
                title = "BBC"
                favoritesButton.setTitle("Go to Favorites", for: .normal)
            }
        }
    }
    
    weak var delegate: HeadlinesListViewControllerDelegate?
    var moreResults: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isFavoritesList {
            title = "BBC"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFavoritesList {
            delegate?.headlinesListWillAppear(self)
        }
    }
    
    @IBAction func favoritesButtonTapped(_ sender: Any) {
        delegate?.headlinesListDidTapFavoritesButton(self)
    }
}

extension HeadlinesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.headlinesList(self, didSelectHeadline: stories[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HeadlinesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlinesCell") as! HeadlinesCell
        cell.bind(stories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == stories.count - 1 else { return }
        if moreResults {
            tableView.tableFooterView?.isHidden = false
            delegate?.headlinesListDidReachBottom(self)
        } else {
            tableView.tableFooterView?.isHidden = true
        }
    }
}

#if DEBUG
extension HeadlinesListViewController {
    var exposedTableView: UITableView {
        return tableView
    }
}
#endif
