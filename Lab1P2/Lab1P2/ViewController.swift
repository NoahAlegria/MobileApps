//
//  ViewController.swift
//  Lab1P2
//
//  Created by user144566 on 8/28/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var weightSlider: UISlider!
    
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var heightField: UITextField!
    
    @IBOutlet weak var bmiField: UITextField!
    @IBOutlet weak var outputField: UITextField!
    var BMI = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        var temp = Double(sender.value)
        heightField.text = "\(temp)"
        var getWeight = 0.0
        
        if weightField.text != ""
        {
             getWeight = Double(weightField.text!)!
             BMI = (temp / (getWeight * getWeight)) * 703
        }
        
        bmiField.text = " \(BMI) "
        
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
    
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        var temp = Double(sender.value)
        weightField.text = "\(temp)"
        var getHeight = 0.0
        
        if heightField.text != ""
        {
            getHeight = Double(heightField.text!)!
            BMI = (temp / (getHeight * getHeight)) * 703
        }
        
        bmiField.text = " \(BMI) "
        
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

