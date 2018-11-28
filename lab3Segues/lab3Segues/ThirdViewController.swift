//
//  ThirdViewController.swift
//  lab3Segues
//
//  Created by user144566 on 9/12/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var earthWeight: UITextField!
    @IBOutlet weak var moonWeight: UITextField!
    @IBOutlet weak var jupiterWeight: UITextField!
    
    var earthToJupiter : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        earthWeight.isUserInteractionEnabled = false
        moonWeight.isUserInteractionEnabled = false
        jupiterWeight.isUserInteractionEnabled = false
        
        if earthToJupiter != nil
        {
            earthWeight.text = String(earthToJupiter!)
            moonWeight.text = String(earthToJupiter! / 6)
            jupiterWeight.text = String(earthToJupiter! * 2.4)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
