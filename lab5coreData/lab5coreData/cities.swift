//
//  cities.swift
//  lab5coreData
//
//  Created by user144566 on 10/18/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class cities {
        var cities:[city] = []
        let citySectionTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        init()
        {
            let city1 = city(name: "Paris", desc: "Great for Cheese and Wine, awful for smell", img: UIImage(named: "paris.jpg")!, ext: "Home of the Eiffel Tower, Le Louvre, and many people who don't believe in deoderant.")
            let city2 = city(name: "Venice", desc: "The city of water is slowly sinking", img: UIImage(named: "venice.jpg")!, ext: "This city actually sinks 2 cm every year! Better visit while you can.")
            let city3 = city(name: "Los Angeles", desc: "City of Angels.", img: UIImage(named: "LA.png")!, ext: "Home of the 3 W's of life. 'Before you discuss your love you lust, make sure you visit here first, Cali'")
            let city4 = city(name: "London", desc: "Is she STILL the Queen?", img: UIImage(named: "london.jpg")!, ext: "'Oi m8, the Beatles n tea.'- Me pretending to know anything about the Brits")
            let city5 = city(name: "Moon", desc: "Population: 0", img: UIImage(named: "moonGoat copy.jpg")!, ext: "Huh... Maybe that's what they mean when people say there's a face in the moon. I wonder how he got there")
            
            cities.append(city4)
            cities.append(city3)
            cities.append(city5)
            cities.append(city1)
            cities.append(city2)
        }
        
    }
    
    class city
    {
        var cityName:String?
        var cityDescription:String?
        var cityImage:UIImage?
        var extDesc:String?
        
        init(name:String, desc:String, img:UIImage, ext:String)
        {
            cityName = name
            cityDescription = desc
            cityImage = img
            extDesc = ext
        }
        
    }

