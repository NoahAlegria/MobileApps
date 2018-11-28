//
//  ViewController.swift
//  lab2
//
//  Created by user144566 on 9/4/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var foodItem: UITextField!
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var searchedFood: UITextField!
    @IBOutlet weak var searchedLocation: UITextField!
    
    var fullMenu : menuDictionary = menuDictionary()
    var menuArr = [menuItem]()
    var i : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        searchedFood.isUserInteractionEnabled = false
        searchedLocation.isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func createRecord(_ sender: UIBarButtonItem)
    {
        if foodItem.text != "",
            location.text != ""
        {
            //add item
            let temp = menuItem(n: foodItem.text!, l: location.text!)
            fullMenu.addRecord(m: temp)
            menuArr.append(temp)

            
            //reset fields
            self.foodItem.text = ""
            self.location.text = ""
        }
        else
        {
            //tell user something is wrong
            let alert = UIAlertController(title: "Data Input Error", message: "Data Inputs are either empty or incorrect types", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func toolSearch(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Search Record", message: "", preferredStyle: .alert)
        
        let serachAction = UIAlertAction(title: "Search", style: .default) { (aciton) in
            
            let text = alertController.textFields!.first!.text!
            
            if !text.isEmpty {
                let food = text
                let temp =  self.fullMenu.search(item: food)
                if let x = temp {
                    self.searchedFood.text = x.name!
                    self.searchedLocation.text = String(x.location!)
                }
                else
                {
                    let alert = UIAlertController(title: "Search Record", message: "Item Not Found", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "enter food item here"
        }
        
        alertController.addAction(serachAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deleteRecord(_ sender: UIBarButtonItem)
    {
        if foodItem.text != ""
        {
            if (fullMenu.search(item: foodItem.text!)) != nil
            {
                fullMenu.deleteRecord(s: foodItem.text!)
                let newArr = Array(fullMenu.menu.values)
                menuArr = newArr
                
                foodItem.text = ""
                location.text = ""
                i = 0
                
            }
            else
            {
                let alert = UIAlertController(title: "Error", message: "Item Not Found", preferredStyle: .alert)
                
                alert .addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        else
        {
            //display error
            let alert = UIAlertController(title: "Data Input Error", message: "Data Inputs are either empty or incorrect types", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func editSearchResult(_ sender: UIButton)
    {
        if searchedFood.text != "",
            searchedLocation.text != ""
        {
            let alertController = UIAlertController(title: "Edit Location", message: "", preferredStyle: .alert)
            
            let editAction = UIAlertAction(title: "Edit", style: .default) { (aciton) in
                
                let text = alertController.textFields!.first!.text!
                
                if !text.isEmpty {
                    let newLoc = text
                    let temp =  self.fullMenu.search(item: self.searchedFood.text!)
                    if let x = temp {
                        x.location = newLoc
                        self.searchedLocation.text = String(x.location!)
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "enter new location here"
            }
            
            alertController.addAction(editAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            //display error
            let alert = UIAlertController(title: "Data Input Error", message: "Data Inputs are either empty or incorrect types", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem)
    {
        if menuArr.count != 0
        {
            if i == 0
            {
                //first item
                searchedFood.text = menuArr[i].name
                searchedLocation.text = menuArr[i].location
                i = i + 1
            }
            else if i == menuArr.count
            {
                let alert = UIAlertController(title: "Search Results", message: "No More Records", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                i = i - 1
            }
            else if i > 0 && i < menuArr.count
            {
                searchedFood.text = menuArr[i].name
                searchedLocation.text = menuArr[i].location
                i = i + 1
            }
            else
            {
                i = menuArr.count - 1
                let alert = UIAlertController(title: "Search Results", message: "No More Records", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        else
        {
            let alert = UIAlertController(title: "Search Results", message: "No Records Yet", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    
    @IBAction func prevButtonPressed(_ sender: UIBarButtonItem)
    {
        if menuArr.count != 0
        {
            if i == 0
            {
                //first item
                searchedFood.text = menuArr[i].name
                searchedLocation.text = menuArr[i].location
            
        let alert = UIAlertController(title: "Search Results", message: "Showing First Record", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
                i = i + 1
            }
            else
            {
                i = i - 1
                searchedFood.text = menuArr[i].name
                searchedLocation.text = menuArr[i].location
                
            }
        }
        else
        {
            let alert = UIAlertController(title: "Search Results", message: "No Records Yet", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}

