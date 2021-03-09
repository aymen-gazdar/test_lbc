//
//  AnnouncesListViewController.swift
//  TestLBC
//
//  Created by Aymen on 08/03/2021.
//

import UIKit

class AnnouncesListViewController: UITableViewController {

    //MARK: life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    //MARK: private methods
    
    private func setupUI() {
        self.title = NSLocalizedString("Liste d'annonces", comment: "")
        self.tableView.register(AnnounceTableViewCell.self, forCellReuseIdentifier: AnnounceTableViewCell.kAnnounceTableViewCellIdentifier)
        self.tableView.reloadData()
    }

}

//MARK: UITableView delegate/datasource methods

extension AnnouncesListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AnnounceTableViewCell.kAnnounceTableViewCellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let announceCell = tableView.dequeueReusableCell(withIdentifier: AnnounceTableViewCell.kAnnounceTableViewCellIdentifier, for: indexPath) as? AnnounceTableViewCell {
            announceCell.setupCell()
            return announceCell
        }
        return UITableViewCell()
    }
}

