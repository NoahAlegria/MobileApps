//
//  FirstViewController.swift
//  lab1Full
//
//  Created by user144566 on 8/29/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var bmiOutput: UITextField!
    @IBOutlet weak var outputField: UILabel!
    
    @IBOutlet weak var heightField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = "BMI Caluclator"
        welcomeLabel.textColor = UIColor.blue
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var weightField: UITextField!
    
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
            outputField.textColor = UIColor.blue
            outputField.text = "You are underweight"
        case BMI >= 18 && BMI < 25:
            outputField.textColor = UIColor.green
            outputField.text = "You are normal"
        case BMI >= 25 && BMI <= 30:
            outputField.textColor = UIColor.purple
            outputField.text = "You are pre-obese"
        case BMI > 30:
            outputField.textColor = UIColor.red
            outputField.text = "You are obese"
        default:
            print("Oops")
            
        }
    }
    
}

