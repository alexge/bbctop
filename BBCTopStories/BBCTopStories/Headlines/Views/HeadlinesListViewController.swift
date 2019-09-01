//
//  HeadlinesListViewController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

protocol HeadlinesListViewControllerDelegate: class {
    func willReachBottom()
}

final class HeadlinesListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var stories = [Story]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    weak var delegate: HeadlinesListViewControllerDelegate?
    var moreResults: Bool = true
}

extension HeadlinesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
            delegate?.willReachBottom()
        } else {
            tableView.tableFooterView?.isHidden = true
        }
    }
}
