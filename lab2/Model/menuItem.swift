//
//  menuItem.swift
//  lab2
//
//  Created by user144566 on 9/4/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit
import Foundation

class menuItem{
    
    var name:String? = nil
    var location:String? = nil
    
    init(n:String, l:String) {
        self.name = n
        self.location = l
    }
    
    func setLocation(newLoc:String) {
        self.location = newLoc
    }
}
