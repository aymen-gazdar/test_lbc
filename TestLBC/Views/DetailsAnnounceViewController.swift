//
//  DetailsAnnounceViewController.swift
//  TestLBC
//
//  Created by Aymen on 09/03/2021.
//

import UIKit

class DetailsAnnounceViewController: UIViewController {

    //MARK: var let
    
    var announce: Announce? {
        didSet {
            self.setupAnnounceInfo()
        }
    }
    
    static let kPading: CGFloat = 15.0
    
    static let kUrgentImageViewSize: CGFloat = 20.0

    //MARK: subviews
    
    var scrollView: UIScrollView = UIScrollView()
    var subView: UIView = UIView()

    var annouceImageView: UIImageView = UIImageView()
    
    var announceUrgentImageView: UIImageView = UIImageView()
    
    var announceTitleLabel: UILabel = UILabel()
    
    var announceDescriptionLabel: UILabel = UILabel()
    
    var announceDescriptionTextLabel: UILabel = UILabel()

    var priceAnnounceLabel: UILabel = UILabel()
    
    var categoryAnnounceLabel: UILabel = UILabel()
    
    var creationDateAnnounceLabel: UILabel = UILabel()
    
    var siretAnnounceLabel: UILabel = UILabel()

    //MARK: life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()

    }

    //MARK: private methods

    private func setupAnnounceInfo(){
        guard let announce = self.announce else {
            return
        }
        self.annouceImageView.loadImageAsync(with: announce.imagesUrl.thumb, placeHolder: "lbc_placeholder")
        self.announceUrgentImageView.isHidden = !announce.isUrgent
        self.announceTitleLabel.text = announce.title
        self.announceDescriptionTextLabel.text = announce.description
        self.priceAnnounceLabel.text = announce.price?.euroFormat
        self.categoryAnnounceLabel.text = String(announce.categoryId)
        self.creationDateAnnounceLabel.text = announce.creationDate.stringDate
        
        if let siret = announce.siret {
            self.siretAnnounceLabel.text = "\(NSLocalizedString("SIRET : ", comment: "")) \(siret)"
            
        } else {
            self.siretAnnounceLabel.text = ""
            
        }

    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.prepareScrollView()
        self.prepareAnnouceImageView()
        self.prepareAnnounceUrgentImageView()
        self.prepareAnnounceTitleLabel()
        self.preparePriceAnnounceLabel()
        self.prepareCreationDateAnnounceLabel()
        self.prepareCategoryAnnounceLabel()
        self.prepareAnnounceDescriptionLabel()
        self.prepareAnnounceDescriptionTextLabel()
        self.prepareSiretAnnounceLabel()
    }
    
    func prepareScrollView(){
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.subView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.subView)
        self.view.addSubview(self.scrollView)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),

            self.subView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.subView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.subView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.subView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.subView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor)
        ])
        
    }
    
    func prepareAnnouceImageView(){
        self.subView.addSubview(self.annouceImageView)
        self.annouceImageView.contentMode = .scaleAspectFill
        self.annouceImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.annouceImageView.topAnchor.constraint(equalTo: self.subView.topAnchor),
            self.annouceImageView.widthAnchor.constraint(equalTo: self.subView.widthAnchor),
            self.annouceImageView.heightAnchor.constraint(equalTo: self.annouceImageView.widthAnchor)
        ])
    }
    
    private func prepareAnnounceUrgentImageView(){
        self.subView.addSubview(self.announceUrgentImageView)
        self.announceUrgentImageView.image = UIImage(named: "lbc_urgent_icon")
        self.announceUrgentImageView.contentMode = .scaleAspectFit
        self.announceUrgentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.announceUrgentImageView.widthAnchor.constraint(equalToConstant: Self.kUrgentImageViewSize),
            self.announceUrgentImageView.heightAnchor.constraint(equalTo: self.announceUrgentImageView.widthAnchor),
            self.announceUrgentImageView.topAnchor.constraint(equalTo: self.annouceImageView.bottomAnchor, constant: Self.kPading),
            self.announceUrgentImageView.trailingAnchor.constraint(equalTo: self.subView.trailingAnchor, constant: -Self.kPading)
        ])
    }
    
    private func prepareAnnounceTitleLabel(){
        self.subView.addSubview(self.announceTitleLabel)
        self.announceTitleLabel.textColor = .black
        self.announceTitleLabel.numberOfLines = 0
        self.announceTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        self.announceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.announceTitleLabel.leadingAnchor.constraint(equalTo:self.subView.leadingAnchor, constant: Self.kPading),
            self.announceTitleLabel.trailingAnchor.constraint(equalTo: self.announceUrgentImageView.leadingAnchor, constant: -Self.kPading),
            self.announceTitleLabel.topAnchor.constraint(equalTo: self.annouceImageView.bottomAnchor, constant: Self.kPading)
        ])
    }
    
    private func preparePriceAnnounceLabel(){
        self.subView.addSubview(self.priceAnnounceLabel)
        self.priceAnnounceLabel.textColor = .orange
        self.priceAnnounceLabel.numberOfLines = 1
        self.priceAnnounceLabel.font = UIFont.boldSystemFont(ofSize: 22)
        self.priceAnnounceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.priceAnnounceLabel.leadingAnchor.constraint(equalTo: self.announceTitleLabel.leadingAnchor),
            self.priceAnnounceLabel.topAnchor.constraint(equalTo: self.announceTitleLabel.bottomAnchor, constant: Self.kPading)
        ])
    }
    
    private func prepareCreationDateAnnounceLabel(){
        self.subView.addSubview(self.creationDateAnnounceLabel)
        self.creationDateAnnounceLabel.textColor = .black
        self.creationDateAnnounceLabel.numberOfLines = 1
        self.creationDateAnnounceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.creationDateAnnounceLabel.textColor = .darkGray
        self.creationDateAnnounceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.creationDateAnnounceLabel.leadingAnchor.constraint(equalTo: self.announceTitleLabel.leadingAnchor),
            self.creationDateAnnounceLabel.topAnchor.constraint(equalTo: self.priceAnnounceLabel.bottomAnchor, constant: Self.kPading/2)
        ])
    }
    
    private func prepareCategoryAnnounceLabel(){
        self.subView.addSubview(self.categoryAnnounceLabel)
        self.categoryAnnounceLabel.textColor = .darkGray
        self.categoryAnnounceLabel.numberOfLines = 1
        self.categoryAnnounceLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        self.categoryAnnounceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.categoryAnnounceLabel.leadingAnchor.constraint(equalTo: self.announceTitleLabel.leadingAnchor),
            self.categoryAnnounceLabel.topAnchor.constraint(equalTo: self.creationDateAnnounceLabel.bottomAnchor, constant: Self.kPading/2)
        ])
    }
    
    private func prepareAnnounceDescriptionLabel(){
        self.subView.addSubview(self.announceDescriptionLabel)
        self.announceDescriptionLabel.text = NSLocalizedString("Description", comment: "")
        self.announceDescriptionLabel.textColor = .black
        self.announceDescriptionLabel.numberOfLines = 1
        self.announceDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.announceDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.announceDescriptionLabel.leadingAnchor.constraint(equalTo: self.announceTitleLabel.leadingAnchor),
            self.announceDescriptionLabel.topAnchor.constraint(equalTo: self.categoryAnnounceLabel.bottomAnchor, constant: Self.kPading*2)
        ])
    }
    
    private func prepareAnnounceDescriptionTextLabel(){
        self.subView.addSubview(self.announceDescriptionTextLabel)
        self.announceDescriptionTextLabel.textColor = .black
        self.announceDescriptionTextLabel.numberOfLines = 0
        self.announceDescriptionTextLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.announceDescriptionTextLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.announceDescriptionTextLabel.leadingAnchor.constraint(equalTo: self.announceTitleLabel.leadingAnchor),
            self.announceDescriptionTextLabel.topAnchor.constraint(equalTo: self.announceDescriptionLabel.bottomAnchor, constant: Self.kPading),
            self.announceDescriptionTextLabel.trailingAnchor.constraint(equalTo: self.announceUrgentImageView.leadingAnchor, constant: Self.kPading)
            
        ])
    }
    
    private func prepareSiretAnnounceLabel(){
        self.subView.addSubview(self.siretAnnounceLabel)
        self.siretAnnounceLabel.textColor = .gray
        self.siretAnnounceLabel.numberOfLines = 1
        self.siretAnnounceLabel.font = UIFont.italicSystemFont(ofSize: 16)
        self.siretAnnounceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.siretAnnounceLabel.leadingAnchor.constraint(equalTo: self.announceTitleLabel.leadingAnchor),
            self.siretAnnounceLabel.topAnchor.constraint(equalTo: self.announceDescriptionTextLabel.bottomAnchor, constant: Self.kPading*2),
            self.siretAnnounceLabel.bottomAnchor.constraint(equalTo: self.subView.bottomAnchor, constant: -Self.kPading)

        ])
    }
}
