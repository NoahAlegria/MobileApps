//
//  SecondViewController.swift
//  lab3Segues
//
//  Created by user144566 on 9/12/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var earthWeight: UITextField!
    @IBOutlet weak var moonWeight: UITextField!
    @IBOutlet weak var travelDisplayField: UILabel!
    
    var earthWeightpassed : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        earthWeight.isUserInteractionEnabled = false
        moonWeight.isUserInteractionEnabled = false
        travelDisplayField.isUserInteractionEnabled = false
        
        if earthWeightpassed != nil 
        {
            earthWeight.text = String(earthWeightpassed!)
            moonWeight.text = String(earthWeightpassed! / 6)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toJupiter"
        {
            let des = segue.destination as! ThirdViewController
            des.earthToJupiter = earthWeightpassed
        }
        
    }
    
    @IBAction func fromJupiterToMoon(segue: UIStoryboardSegue)
    {
        if segue.source is ThirdViewController {
            travelDisplayField.text = "Coming from Jupiter"
            
        }
    }

}
