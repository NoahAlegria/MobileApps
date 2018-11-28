//
//  ViewController.swift
//  lab4TableView
//
//  Created by user144566 on 9/24/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cityList : cities = cities()

    @IBOutlet weak var cityTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        cell.layer.borderWidth = 1.0
        cell.cityTitle.text = cityList.cities[indexPath.row].cityName;
        cell.cityDescription.text = cityList.cities[indexPath.row].cityDescription
        
        cell.cityImage.image = UIImage(named: cityList.cities[indexPath.row].cityImage!)
        
        
        return cell
    }
    
   override func viewWillAppear(_ animated: Bool) {
        cityTable.rowHeight = 85
    }
    
    
    // delete selected entry
    //THIS ACTUALLY IS A "SLIDE TO DELETE" FUNCTION
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    
    //changed to private to make warning go away, may be issue
    private func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle { return UITableViewCellEditingStyle.delete }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        print("DELETING")
        cityList.cities.remove(at: indexPath.row)
            
        //Method 1 (I like this better I think, but am unsure why)
        self.cityTable.beginUpdates()
        self.cityTable.deleteRows(at: [indexPath], with: .automatic)
        self.cityTable.endUpdates()
        }
      
    // add a new city to the table
    @IBAction func addAndReload(_ sender: Any) {
    
    
        let alert = UIAlertController(title: "Add New City", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter City Name or Address"
        })
        alert.addTextField(configurationHandler: {textField in textField.placeholder = "Enter Description Here (Must have one)"})
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let name = alert.textFields?.first?.text,
                let desc = alert.textFields?.last?.text {
                print("New City: \(name)")
                let newCity = city(name: name, desc: "Generic Description", img: "hogwarts.jpg", ext: desc)
                self.cityList.cities.append(newCity)
                
                //Method 1
                
                let indexPath = IndexPath (row: self.cityList.cities.count - 1, section: 0)
                self.cityTable.beginUpdates()
                self.cityTable.insertRows(at: [indexPath], with: .automatic)
                self.cityTable.endUpdates()
                
            }
        }))
        
        self.present(alert, animated: true)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        let currCity = cityList.cities[selectedIndex.row]
        
        if(segue.identifier == "detailView"){
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.citySelected = currCity
            }
        }
    }
}

