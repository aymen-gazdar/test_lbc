//
//  AnnounceTableViewCell.swift
//  TestLBC
//
//  Created by Aymen on 08/03/2021.
//

import UIKit

class AnnounceTableViewCell: UITableViewCell {

    //MARK: var let
    
    static let kAnnounceTableViewCellIdentifier = "AnnounceTableViewCellIdentifier"
    static let kAnnounceTableViewCellHeight: CGFloat = 150.0

    static let kPading: CGFloat = 10.0
    static let kAnnouceImageViewSize: CGFloat = 130.0
    static let kUrgentImageViewSize: CGFloat = 20.0

        //MARK: subviews
    
    var annouceImageView: UIImageView = UIImageView()
    
    var announceUrgentImageView: UIImageView = UIImageView()

    var announceTitleLabel: UILabel = UILabel()

    var priceAnnounceLabel: UILabel = UILabel()
    
    var categoryAnnounceLabel: UILabel = UILabel()

    var creationDateAnnounceLabel: UILabel = UILabel()

    //MARK: init cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Self.kAnnounceTableViewCellIdentifier)
        
        self.setupUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: Setup cell method
    
    func setupCell(){
        self.annouceImageView.image = UIImage(named: "lbc_placeholder")
        self.announceUrgentImageView.image = UIImage(named: "lbc_urgent_icon")
        self.announceTitleLabel.text = "Carte graphique pour PC portable Dell inspire N series 2011"
        self.priceAnnounceLabel.text = "100€"
        self.categoryAnnounceLabel.text = "Informatique"
        self.creationDateAnnounceLabel.text = "aujoud'hui 21:30"

    }

    //MARK: Setup UI methods

    private func setupUI() {
        self.prepareAnnounceImageView()
        self.prepareAnnounceUrgentImageView()
        self.prepareAnnounceTitleLabel()
        self.preparePriceAnnounceLabel()
        self.prepareCreationDateAnnounceLabel()
        self.prepareCategoryAnnounceLabel()
        self.accessoryType = .disclosureIndicator

    }
    
    private func prepareAnnounceImageView(){
        self.addSubview(self.annouceImageView)
        self.annouceImageView.contentMode = .scaleAspectFit
        self.annouceImageView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            self.annouceImageView.widthAnchor.constraint(equalToConstant: Self.kAnnouceImageViewSize),
            self.annouceImageView.heightAnchor.constraint(equalToConstant: Self.kAnnouceImageViewSize),
            self.annouceImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.kPading),
            self.annouceImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.kPading)
        ])
    }
    
    private func prepareAnnounceTitleLabel(){
        self.addSubview(self.announceTitleLabel)
        self.announceTitleLabel.textColor = .black
        self.announceTitleLabel.numberOfLines = 2
        self.announceTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        self.announceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.announceTitleLabel.leadingAnchor.constraint(equalTo:self.annouceImageView.trailingAnchor, constant: Self.kPading),
            self.announceTitleLabel.trailingAnchor.constraint(equalTo: self.announceUrgentImageView.leadingAnchor, constant: -Self.kPading),
            self.announceTitleLabel.topAnchor.constraint(equalTo: self.annouceImageView.topAnchor)
        ])
    }
    
    private func preparePriceAnnounceLabel(){
        self.addSubview(self.priceAnnounceLabel)
        self.priceAnnounceLabel.textColor = .orange
        self.priceAnnounceLabel.numberOfLines = 1
        self.priceAnnounceLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.priceAnnounceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.priceAnnounceLabel.leadingAnchor.constraint(equalTo: self.announceTitleLabel.leadingAnchor),
            self.priceAnnounceLabel.topAnchor.constraint(equalTo: self.announceTitleLabel.bottomAnchor, constant: Self.kPading)
        ])
    }
    
    private func prepareCategoryAnnounceLabel(){
        self.addSubview(self.categoryAnnounceLabel)
        self.categoryAnnounceLabel.textColor = .black
        self.categoryAnnounceLabel.numberOfLines = 1
        self.categoryAnnounceLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        self.categoryAnnounceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.categoryAnnounceLabel.leadingAnchor.constraint(equalTo: self.announceTitleLabel.leadingAnchor),
            self.categoryAnnounceLabel.bottomAnchor.constraint(equalTo: self.creationDateAnnounceLabel.topAnchor, constant: -Self.kPading)
        ])
    }
    
    private func prepareCreationDateAnnounceLabel(){
        self.addSubview(self.creationDateAnnounceLabel)
        self.creationDateAnnounceLabel.textColor = .black
        self.creationDateAnnounceLabel.numberOfLines = 1
        self.creationDateAnnounceLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        self.creationDateAnnounceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.creationDateAnnounceLabel.leadingAnchor.constraint(equalTo: self.announceTitleLabel.leadingAnchor),
            self.creationDateAnnounceLabel.bottomAnchor.constraint(equalTo: self.annouceImageView.bottomAnchor)
        ])
    }
    
    private func prepareAnnounceUrgentImageView(){
        self.addSubview(self.announceUrgentImageView)
        self.announceUrgentImageView.contentMode = .scaleAspectFit
        self.announceUrgentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.announceUrgentImageView.widthAnchor.constraint(equalToConstant: Self.kUrgentImageViewSize),
            self.announceUrgentImageView.heightAnchor.constraint(equalToConstant: Self.kUrgentImageViewSize),
            self.announceUrgentImageView.topAnchor.constraint(equalTo: self.annouceImageView.topAnchor),
            trailingAnchor.constraint(equalTo: self.announceUrgentImageView.trailingAnchor, constant: Self.kPading)
        ])
    }
    
}
