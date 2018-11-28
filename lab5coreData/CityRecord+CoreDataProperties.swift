//
//  CityRecord+CoreDataProperties.swift
//  lab5coreData
//
//  Created by user144566 on 10/18/18.
//  Copyright © 2018 user144566. All rights reserved.
//
//

import Foundation
import CoreData


extension CityRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityRecord> {
        return NSFetchRequest<CityRecord>(entityName: "CityRecord")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var cityDescription: String?
    @NSManaged public var cityImage: NSData?

}
