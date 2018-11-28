//
//  ViewController.swift
//  lab3Segues
//
//  Created by user144566 on 9/11/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var origWeightField: UITextField!
    @IBOutlet weak var travelDisplayField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMoon"
        {
            let des = segue.destination as! SecondViewController
            let earthWeight = Double(origWeightField.text!)
            des.earthWeightpassed = earthWeight
        }

    }
    
    @IBAction func fromMoonToEarth(segue: UIStoryboardSegue)
    {
        if segue.source is SecondViewController {
            travelDisplayField.text = "Coming from the Moon"
        }
    }
    
    @IBAction func fromJupiterToEarth(segue: UIStoryboardSegue)
    {
        if segue.source is ThirdViewController {
            travelDisplayField.text = "Coming from Jupiter"
        }
    }
    
}

