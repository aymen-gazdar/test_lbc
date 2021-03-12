//
//  CategoryTableViewController.swift
//  TestLBC
//
//  Created by Aymen on 10/03/2021.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    //MARK: - var let
    
    static let kCategoryCellIdentifier = "CategoryCellIdentifier"
        
    //MARK: - life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        
    }

    //MARK: - private methods
    
    private func setupUI() {
        self.title = NSLocalizedString("Filtre par categories", comment: "")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Fermer", comment: ""), style: .done, target: self, action: #selector(fermerButtonAction))

        let navBarAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.orange]
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = navBarAttributes
            
        } else {
            self.navigationController?.navigationBar.titleTextAttributes = navBarAttributes
            
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.kCategoryCellIdentifier)
        self.tableView.reloadData()
    }
    
    @objc
    private func fermerButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }

   
}

// MARK: - Table view data source

extension CategoryTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.kCategoryCellIdentifier, for: indexPath)
        cell.textLabel?.text = "Categorie \(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Utils.log(log: "did select row")
        self.fermerButtonAction()
    }
    
}