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

    static let kAnnouceImageViewPading: CGFloat = 10.0
    static let kAnnouceImageViewSize: CGFloat = 100.0

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
    
    //MARK: Setup UI methods

    private func setupUI() {
        //TODO: prepare subviews
    }
    
}
