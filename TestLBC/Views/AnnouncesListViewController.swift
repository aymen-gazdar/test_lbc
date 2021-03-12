//
//  AnnouncesListViewController.swift
//  TestLBC
//
//  Created by Aymen on 08/03/2021.
//

import UIKit

class AnnouncesListViewController: UITableViewController {

    //MARK: var let

    let viewModel: AnnouncesViewModel = AnnouncesViewModel()
    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)

    var announcesList: [Announce] = []
    
    //MARK: life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        
        self.viewModel.loadAnnouncesList()
        
    }

    //MARK: private methods
    
    private func setupUI() {
        
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.center = self.view.center

        self.title = NSLocalizedString("Liste d'annonces", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Filtrer", comment: ""), style: .plain, target: self, action: #selector(filterButtonAction))
        
        let navBarAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.orange]
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = navBarAttributes
            
        } else {
            self.navigationController?.navigationBar.titleTextAttributes = navBarAttributes
            
        }
        
        self.viewModel.delegate = self
        self.tableView.register(AnnounceTableViewCell.self, forCellReuseIdentifier: AnnounceTableViewCell.kAnnounceTableViewCellIdentifier)
    }
    
    @objc
    private func filterButtonAction() {
        let categoryTableViewController = CategoryTableViewController()
        let navController = UINavigationController.init(rootViewController: categoryTableViewController)
        self.present(navController, animated: true, completion: nil)
    }
    
}

//MARK: UITableView delegate/datasource methods

extension AnnouncesListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.announcesList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AnnounceTableViewCell.kAnnounceTableViewCellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let announceCell = tableView.dequeueReusableCell(withIdentifier: AnnounceTableViewCell.kAnnounceTableViewCellIdentifier, for: indexPath) as? AnnounceTableViewCell {
            announceCell.announce = self.announcesList[indexPath.row]
            return announceCell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsAnnounceViewController = DetailsAnnounceViewController()
        detailsAnnounceViewController.announce = self.announcesList[indexPath.row]
        self.splitViewController?.showDetailViewController(detailsAnnounceViewController, sender: self)
        
    }
}

extension AnnouncesListViewController: AnnouncesViewModelProtocol {
    func viewModelDidSendEvent(event: AnnouncesViewModelEvent) {
        
        Utils.runOnMainThread {
            switch event {
            case .reloadView(let announces):
                self.announcesList = announces
                self.tableView.reloadData()

            case .error( let error):
                self.displayAlert(with: NSLocalizedString("Erreur", comment: ""), message: error.localizedDescription)
            case .displayLoader:
                self.activityIndicator.startAnimating()

            case .hideLoader:
                self.activityIndicator.stopAnimating()

            }
        }
        
    }
    
    func displayAlert(with title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("Fermer", comment: ""), style: .cancel, handler: nil))

        if self.presentedViewController == nil {
            self.present(alert, animated: true)
            
        } else {
            self.dismiss(animated: false) { () -> Void in
                self.present(alert, animated: true)
            }
        }
        
    }
    
}
