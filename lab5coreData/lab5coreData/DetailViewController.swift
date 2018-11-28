//
//  DetailViewController.swift
//  lab5coreData
//
//  Created by user144566 on 10/18/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var citySelected : CityRecord?
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitle.isUserInteractionEnabled = false
        detailDesc.isUserInteractionEnabled = false
        if citySelected != nil {
            let imgData = citySelected?.cityImage
            if let image = UIImage(data: imgData! as Data) {
                detailImage.image = image }
            //detailImage.image = citySelected?.cityImage
            detailTitle.text = citySelected?.cityName
            detailDesc.text = citySelected?.cityDescription
        }
    }

}
