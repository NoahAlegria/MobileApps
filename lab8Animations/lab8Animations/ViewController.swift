//
//  ViewController.swift
//  lab8Animations
//
//  Created by user144566 on 11/19/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var banana1 : UIImageView!
    @IBOutlet weak var banana2 : UIImageView!
    @IBOutlet weak var banana3 : UIImageView!
    @IBOutlet weak var banana4 : UIImageView!
    @IBOutlet weak var monkey : UIImageView!
    @IBOutlet weak var timerVal: UILabel!
    var playedOnce : Bool!
    
    var timer : Timer?
    var counter  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.monkey.image = UIImage(named: "appleMonkey.jpeg")
        
        self.banana1.image = UIImage(named: "banana.jpg")
        self.banana2.image = UIImage(named: "banana.jpg")
        self.banana3.image = UIImage(named: "banana.jpg")
        self.banana4.image = UIImage(named: "banana.jpg")
        
        timer = Timer()
        playedOnce = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func count()
    {
        counter = counter + 1
        timerVal.text  = String( counter)
        if counter == 10 {
            if didWin() {
                let innerAlert = UIAlertController(title: "You Won!", message: nil, preferredStyle: .alert)
                innerAlert.addAction(UIAlertAction(title: "Yay", style: .default, handler:nil))
                self.present(innerAlert, animated: true, completion: nil)
            }
            else {
                let innerAlert = UIAlertController(title: "You lost :(", message: nil, preferredStyle: .alert)
                innerAlert.addAction(UIAlertAction(title: "Keep playing", style: .default, handler:nil))
                self.present(innerAlert, animated: true, completion: nil)
            }
        }
    }

    @IBAction func startGame(button: UIButton) {
        if playedOnce {
            print("INVALID")
            timer!.invalidate()
        }
        startTimer()
        showItems()
        playedOnce = true
        counter = -1
    }
    
    func startTimer()  {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)
    }
    
    func showItems() {
        self.banana1.isHidden = false
        self.banana2.isHidden = false
        self.banana3.isHidden = false
        self.banana4.isHidden = false
    }
    
    func checkTouch() {
        if(viewIntersectsView(monkey, second_View: banana1))
        {
            self.banana1.isHidden = true
        }
        
        if(viewIntersectsView(monkey, second_View: banana2))
        {
            self.banana2.isHidden = true
        }
        
        if(viewIntersectsView(monkey, second_View: banana3))
        {
            self.banana3.isHidden = true
        }
        
        if(viewIntersectsView(monkey, second_View: banana4))
        {
            self.banana4.isHidden = true
        }
    }
    
    func didWin() -> Bool {
        if self.banana1.isHidden, self.banana2.isHidden, self.banana3.isHidden, self.banana4.isHidden {
            return true
        }
        else {
            return false
        }
    }

    @IBAction func up(_ sender: UIButton) {
        var frame  = self.monkey.frame
        frame.origin.y -= 10
        self.monkey.frame =  frame
        checkTouch()
    }
    
    @IBAction func left(_ sender: UIButton) {
        var frame  = self.monkey.frame
        frame.origin.x -= 10
        self.monkey.frame =  frame
        
        checkTouch()
    }
    
    @IBAction func right(_ sender: UIButton) {
        var frame  = self.monkey.frame
        frame.origin.x += 10
        self.monkey.frame =  frame
        
        checkTouch()
    }
    
    @IBAction func down(_ sender: UIButton) {
        
        var frame  = self.monkey.frame
        frame.origin.y += 10
        self.monkey.frame =  frame
        
        checkTouch()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewIntersectsView(_ first_View: UIView, second_View:UIView) -> Bool
    {
        return first_View.frame.intersects(second_View.frame)
    }

}

