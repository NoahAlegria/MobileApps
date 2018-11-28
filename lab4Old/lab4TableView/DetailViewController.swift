//
//  DetailViewController.swift
//  lab4TableView
//
//  Created by user144566 on 9/25/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var citySelected : city?
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTitle.isUserInteractionEnabled = false
        detailDesc.isUserInteractionEnabled = false
        if citySelected != nil {
            detailImage.image = UIImage(named: (citySelected?.cityImage)!)
            detailTitle.text = citySelected?.cityName
            detailDesc.text = citySelected?.extDesc
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
