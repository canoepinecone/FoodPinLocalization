//
//  DiscoverTableViewCell.swift
//  FoodPin
//
//  Created by Simon Ng on 10/10/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel! {
        didSet {
            locationLabel.numberOfLines = 0
        }
    }
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
        }
    }
    @IBOutlet var featuredImageView: UIImageView! {
        didSet {
            featuredImageView.contentMode = .scaleAspectFill
            featuredImageView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
