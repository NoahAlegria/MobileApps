//
//  CityTableViewCell.swift
//  lab4TableView
//
//  Created by user144566 on 9/24/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityDescription: UILabel!
    @IBOutlet weak var cityTitle: UILabel!
    @IBOutlet weak var cityImage: UIImageView! {
    didSet {
        //cityImage.layer.cornerRadius = cityImage.bounds.width / 2
        //cityImage.clipsToBounds = true
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
