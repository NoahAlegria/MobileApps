//
//  cities.swift
//  lab4TableView
//
//  Created by user144566 on 9/25/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import Foundation

class cities {
    var cities:[city] = []
    
    init()
    {
        /*let city1 = city(name: "Paris", desc: "Great for Cheese and Wine, awful for smell", img: "paris.jpg", ext: "75008")
        let city2 = city(name: "Venice", desc: "The city of water is slowly sinking", img: "venice.jpg", ext: "30100")
        let city3 = city(name: "Los Angeles", desc: "City of Angels.", img: "LA.png", ext: "90001'")
        */
        let city4 = city(name: "London", desc: "Is she STILL the Queen?", img: "london.jpg", ext: "WC1")
        //let city5 = city(name: "Moon", desc: "Population: 0", img: "moonGoat copy.jpg", ext: "Huh... Maybe that's what they mean when people say there's a face in the moon. I wonder how he got there")
        
        //cities.append(city1)
        //cities.append(city2)
        //cities.append(city3)
        
        cities.append(city4)
        //cities.append(city5)
    }
    
}

class city
{
    var cityName:String?
    var cityDescription:String?
    var cityImage:String?
    var extDesc:String?
    
    init(name:String, desc:String, img:String, ext:String)
    {
        cityName = name
        cityDescription = desc
        cityImage = img
        extDesc = ext
    }
    
}
