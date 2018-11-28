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
    @IBOutlet weak var mapPick: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var searchField: UITextField!
    
    @IBAction func mapViewChanged(_ sender: Any) {
        switch(mapPick.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
            
        case 1:
            map.mapType = MKMapType.satellite
            
        default:
            map.mapType = MKMapType.standard
        }
    }
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
                        
                        let span = MKCoordinateSpanMake(0.05, 0.05)
                        let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                        self.map.setRegion(region, animated: true)
                        let ani = MKPointAnnotation()
                        ani.coordinate = placemark.location!.coordinate
                        ani.title = placemark.locality
                        ani.subtitle = placemark.subLocality
                        
                        self.map.addAnnotation(ani)
                        
                        
                    }
            })
        }
    }

    @IBAction func searchLocal(_ sender: Any) {
        map.removeAnnotations(map.annotations)
        if !(searchField.text!.isEmpty)
        {
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = self.searchField.text//"pizza"
            request.region = map.region
            let search = MKLocalSearch(request: request)
            
            search.start { response, _ in
                guard let response = response else {
                    return
                }
                print( response.mapItems )
                var matchingItems:[MKMapItem] = []
                matchingItems = response.mapItems
                for i in 1...matchingItems.count - 1
                {
                    let place = matchingItems[i].placemark
                    print(place.location?.coordinate.latitude)
                    print(place.location?.coordinate.longitude)
                    print(place.name)
                    let ani = MKPointAnnotation()
                    ani.coordinate = place.location!.coordinate
                    ani.title = place.name
                    ani.subtitle = place.subLocality
                    
                    self.map.addAnnotation(ani)
                    
                }
                
            }
        }
        else {
            print("Error in Search Field")
        }
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
