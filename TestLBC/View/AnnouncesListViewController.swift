//
//  AnnouncesListViewController.swift
//  TestLBC
//
//  Created by Aymen on 08/03/2021.
//

import UIKit

class AnnouncesListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    private func setupUI() {
        self.title = NSLocalizedString("Liste d'annonces", comment: "")
        self.tableView.register(AnnounceTableViewCell.self, forCellReuseIdentifier: AnnounceTableViewCell.kAnnounceTableViewCellIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.reloadData()
    }

}

extension AnnouncesListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let announceCell = tableView.dequeueReusableCell(withIdentifier: AnnounceTableViewCell.kAnnounceTableViewCellIdentifier, for: indexPath) as? AnnounceTableViewCell {
            return announceCell
        }
        return UITableViewCell()
    }
}

