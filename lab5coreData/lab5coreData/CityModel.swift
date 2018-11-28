//
//  CityModel.swift
//  lab5coreData
//
//  Created by user144566 on 10/18/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit
import CoreData
import Foundation

public class CityModel {

    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var   fetchResults =   [CityRecord]()
    
    func fetchRecord() -> Int {
        // Create a new fetch request using the FruitEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CityRecord")
        var x   = 0
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [CityRecord])!
        
        print(fetchResults)
        
        x = fetchResults.count
        
        print(x)
        
        // return howmany entities in the coreData
        return x
        
        
    }
    
    func addCity(name: String, desc: String, img: UIImage)
    {
        // create a new entity object
        let ent = NSEntityDescription.entity(forEntityName: "CityRecord", in: self.managedObjectContext)
        //add to the manege object context
        let newItem = CityRecord(entity: ent!, insertInto: self.managedObjectContext)
        newItem.cityName = name
        newItem.cityDescription = desc
        newItem.cityImage = img.jpegData(compressionQuality: 1) as NSData?
        
        // save the updated context
        do {
            try self.managedObjectContext.save()
        } catch _ {
        }
        
        print(newItem)
    }
    
    func removeCity(row:Int)
    {
        managedObjectContext.delete(fetchResults[row])
        // remove it from the fetch results array
        fetchResults.remove(at:row)
        
        do {
            // save the updated managed object context
            try managedObjectContext.save()
        } catch {
            
        }
        
    }
    
    func getCityObject(row:Int) -> CityRecord
    {
        return fetchResults[row]
    }
    
    func deleteAll()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CityRecord")
        
        // whole fetchRequest object is removed from the managed object context
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
            
            
        }
        catch let _ as NSError {
            // Handle error
        }
        
    }
}
