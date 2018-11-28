//
//  ViewController.swift
//  Lab1
//
//  Created by user144566 on 8/28/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBOutlet weak var bmiOutput: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculate(_ sender: UIButton) {
        let height = Double(self.heightField.text!)!
        let weight = Double(self.weightField.text!)!
        var BMI = 0.0
        view.endEditing(true)
        
        
        if weight > 0 && height > 0
        {
            BMI = (weight/(height * height)) * 703
        }
        bmiOutput.text = "\(BMI)"
        
        switch true {
        case BMI < 18:
            outputLabel.textColor = UIColor.blue
            outputLabel.text = "You are underweight"
        case BMI >= 18 && BMI < 25:
            outputLabel.textColor = UIColor.green
            outputLabel.text = "You are normal"
        case BMI >= 25 && BMI <= 30:
            outputLabel.textColor = UIColor.purple
            outputLabel.text = "You are pre-obese"
        case BMI > 30:
            outputLabel.textColor = UIColor.red
            outputLabel.text = "You are obese"
        default:
            print("Oops")
            
        }
    }
    
}

