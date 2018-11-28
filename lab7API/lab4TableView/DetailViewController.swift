//
//  DetailViewController.swift
//  lab4TableView
//
//  Created by user144566 on 9/25/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    var citySelected : city?
    
    @IBOutlet weak var detailLong: UILabel!
    @IBOutlet weak var detailLat: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var apiLong: UILabel!
    @IBOutlet weak var apiLat: UILabel!
    @IBOutlet weak var apiMag: UILabel!
    
    var long : Double?
    var lat : Double?
    var getLong : Double?
    var getLat : Double?
    var getMag: Double?
    override func viewDidLoad() {
        super.viewDidLoad()


        detailLong.isUserInteractionEnabled = false
        detailLat.isUserInteractionEnabled = false
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        if citySelected != nil {
            //update textboxes
            let geoCoder = CLGeocoder();
            let addressString = citySelected!.cityName!
            CLGeocoder().geocodeAddressString(addressString, completionHandler:
                {(placemarks, error) in
                    
                    if error != nil {
                        print("Geocode failed: \(error!.localizedDescription)")
                    } else if placemarks!.count > 0 {
                        let placemark = placemarks![0]
                        let location = placemark.location
                        let coords = location!.coordinate
                        print(location)
                        self.detailLong.text = String(coords.longitude)
                        self.detailLat.text = String(coords.latitude)
                        self.long = coords.longitude
                        self.lat = coords.latitude
                        self.cityName.text = self.citySelected!.cityName
                        
                        let span = MKCoordinateSpanMake(0.05, 0.05)
                        let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                        
                    }
            })
        }
    }

    @IBAction func getJsonData(_ sender: Any) {
        //Removed async call as it slows down the threads to a mind numbing pace when running on a VM + a simulated iphone
        
        DispatchQueue.main.async(execute: {
            self.getData()
        })
    }
    
    func getData() {
        let north = String(long! + 10)
        let south = String(long! - 10)
        let west = String(lat! + 10)
        let east = String(lat! - 10)
        
        
        var urlAsString = "http://api.geonames.org/earthquakesJSON?north=" + north
        urlAsString += "&south="+south
        urlAsString += "&east="+east
        urlAsString += "&west="+west
        urlAsString += "&username=noahalegria"
        
        print("URL: \(urlAsString)")
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
            print(jsonResult)
            
            
            let setOne = jsonResult["earthquakes"]! as! NSArray
            
            if setOne.count > 0 {
            let element = setOne[0] as? [String: AnyObject]
            
            print(element!["lng"]!)
            print(element!["lat"]!)
            
            self.getLong = (element!["lng"] as? NSNumber)!.doubleValue
            self.getLat = (element!["lat"] as? NSNumber)!.doubleValue
            self.getMag = (element!["magnitude"] as? NSNumber)!.doubleValue
                DispatchQueue.main.async(execute: {
                    self.apiLong.text = String(format: "%.4f", self.getLong!)
                    self.apiLat.text = String(format: "%.4f", self.getLat!)
                    self.apiMag.text = String(format: "%.1f", self.getMag!)
                })
            
            print(element?["magnitude"])
            }
            else {
                print("No Earthquakes Found")
            }
        })
        jsonQuery.resume()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
