//
//  menuDictonary.swift
//  lab2
//
//  Created by user144566 on 9/4/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit
import Foundation

class menuDictionary {
    
    var menu : [String:menuItem] = [String:menuItem] ()
    
    init ()  { }
    
    func addRecord (m:menuItem)
    {
        print("Attempting to add " + m.name! + " to the menu" )
        menu[m.name!] = m
    }
    
    func search (item:String) -> menuItem?
    {
        var flag = false
        
        for (food, _) in menu
        {
            if food == item {
                flag = true
                break
            }
        }
        if flag
        {
            print("FOUND ")
            return menu[item]
        }
        else
        {
            print("Not Found =[ ")
            return nil
        }
    }
    
    func deleteRecord (s:String)
    {
        menu[s] = nil
    }

}
