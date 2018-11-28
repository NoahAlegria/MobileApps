//
//  ViewController.swift
//  lab4TableView
//
//  Created by user144566 on 9/24/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var cityList : cities = cities()
    //dictionary with sections for keys and cities for values
    var cityDict = [String: [city]]()

    @IBOutlet weak var cityTable: UITableView!
    var passedName : String?
    var passedDesc : String?
    var passedKey : String?
    var passedIndex : Int?
    var imageSelected : UIImage!
    var isValid = false
    var isEdit = false
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createCityDict()
        picker.delegate = self
        self.cityTable.setEditing(false, animated: true)
        cityTable.isEditing = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // get the section count
        return cityList.citySectionTitles.count
    }
    
    //possible errors here with wrong sets? Check after
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        // get the section title
        let cityKey = cityList.citySectionTitles[section]
        
        // use the section title to count howmany fruits are in that section
        if let cityValues = cityDict[cityKey]
        {
            print("Section: \(cityKey) has: \(cityValues.count)")
            return cityValues.count
        }
        else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // returns the heading for each section
        return cityList.citySectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        
        // get the section key
        let cityKey = cityList.citySectionTitles[indexPath.section]
        print("Populating cityKey: \(cityKey)")
        
        
        // build each each row for section
        if let cityValues = cityDict[cityKey]{
            cell.cityTitle.text = cityValues[indexPath.row].cityName;
            
            cell.cityDescription.text = cityValues[indexPath.row].cityDescription;
            
            cell.cityImage.image = cityValues[indexPath.row].cityImage!
        }
        
        return cell
        
    }
    
   override func viewWillAppear(_ animated: Bool) {
        cityTable.rowHeight = 85
    }
    
    
   // delete selected entry
    //THIS ACTUALLY IS A "SLIDE TO DELETE" FUNCTION
    /*func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }*/
    
    func tableView(_ _tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print(indexPath.row)
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            print("working")
            let cityKey = self.cityList.citySectionTitles[indexPath.section]
            print("cityKey: \(cityKey)")
            self.cityList.cities.remove(at: indexPath.row)
            self.cityDict[cityKey]!.remove(at: indexPath.row)
            print(self.cityDict[cityKey])
            self.cityTable.reloadData()
        }
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, success) in
            
             self.passedKey = self.cityList.citySectionTitles[indexPath.section]
             self.passedIndex = indexPath.row
            
            
             let alert = UIAlertController(title: "Edit Cell", message: nil, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
             
             alert.addTextField(configurationHandler: {textField in textField.placeholder = "Enter Description Here"})
             
             alert.addAction(UIAlertAction(title: "Use Camera", style: .default, handler: { action in
             
             // does unwrap whole work same as unwrap each field?
             let desc = (alert.textFields?.first?.text)!
             if !(desc.isEmpty) {
                 self.passedDesc = (alert.textFields?.first?.text)!
                 self.isEdit = true
                 if UIImagePickerController.isSourceTypeAvailable(.camera) {
                 self.picker.allowsEditing = false
                 self.picker.sourceType = UIImagePickerControllerSourceType.camera
                 self.picker.cameraCaptureMode = .photo
                 self.picker.modalPresentationStyle = .fullScreen
                 self.present(self.picker,animated: true,completion: nil)
                 } else {
                 print("No camera")
                 }
                 }
             }))
             alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
             
                if !((alert.textFields?.first?.text)!.isEmpty) {
             self.passedDesc = (alert.textFields?.first?.text)
                    self.isEdit = true
             //print("New City: \(self.passedName)")
             self.picker.allowsEditing = false
             self.picker.sourceType = .photoLibrary
             self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
             self.picker.modalPresentationStyle = .popover
             self.present(self.picker, animated: true, completion: nil)
             
                }
             }))
             
             self.present(alert, animated: true)
        }
        edit.backgroundColor = UIColor.green
        let config = UISwipeActionsConfiguration(actions: [delete, edit])
        return config
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    // add a new city to the table
    @IBAction func addAndReload(_ sender: Any) {
        let alert = UIAlertController(title: "Add New City", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the City Here"
        })
        alert.addTextField(configurationHandler: {textField in textField.placeholder = "Enter Description Here"})
        
        alert.addAction(UIAlertAction(title: "Use Camera", style: .default, handler: { action in
            
            // does unwrap whole work same as unwrap each field?
            let name = (alert.textFields?.first?.text)!
            let desc = (alert.textFields?.last?.text)!
            if !(name.isEmpty), !(desc.isEmpty) {
                print("New City: \(name)")
                self.passedName = (alert.textFields?.first?.text)!
                self.passedDesc = (alert.textFields?.last?.text)!
                self.isValid = true
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.picker.allowsEditing = false
                    self.picker.sourceType = UIImagePickerControllerSourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.picker.modalPresentationStyle = .fullScreen
                    self.present(self.picker,animated: true,completion: nil)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            
            if !((alert.textFields?.first?.text)!.isEmpty),
                !((alert.textFields?.last?.text)!.isEmpty){
                self.passedName = (alert.textFields?.first?.text)!
                self.passedDesc = (alert.textFields?.last?.text)!
                //print("New City: \(self.passedName)")
                self.isValid = true
                self.picker.allowsEditing = false
                self.picker.sourceType = .photoLibrary
                self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                self.picker.modalPresentationStyle = .popover
                self.present(self.picker, animated: true, completion: nil)
            }
        }))
        
            self.present(alert, animated: true)
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        print("HERE")
        picker .dismiss(animated: true, completion: nil)
        imageSelected=info[UIImagePickerControllerOriginalImage] as? UIImage
        if (isValid) {
            let newCity = city(name: self.passedName!, desc: self.passedDesc!, img: self.imageSelected, ext: "YER A WIZARD HARRY")
            self.cityList.cities.append(newCity)
            
            //Method 2
            let cityName = self.passedName!
            let endIndex = cityName.index((cityName.startIndex), offsetBy: 1)
            let cityKey = String(cityName[(..<endIndex)])
            
            if var cityObjects = self.cityDict[cityKey] {
                cityObjects.append(newCity)
                self.cityDict[cityKey] = cityObjects
            }
            else {
                self.cityDict[cityKey] = [newCity]
            }
            self.cityList.cities.append(newCity)
            isValid = false
            self.cityTable.reloadData()
        }
        if (isEdit) {
            let tempCity = self.cityDict[passedKey!]![passedIndex!]
            tempCity.cityDescription = passedDesc!
            tempCity.cityImage = imageSelected
            isEdit = false
            self.cityTable.reloadData()
        }

    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        let cityKey = cityList.citySectionTitles[selectedIndex.section]
        let currCity = cityDict[cityKey]![selectedIndex.row]
        
        if(segue.identifier == "detailView"){
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.citySelected = currCity
            }
        }
    }
    func createCityDict() {
        for city in cityList.cities {
            let cityName = city.cityName
            let endIndex = cityName!.index((cityName!.startIndex), offsetBy: 1)
            let cityKey = String(cityName![(..<endIndex)])
            
            if var cityObjects = cityDict[cityKey] {
                cityObjects.append(city)
                cityDict[cityKey] = cityObjects
            }
            else {
                cityDict[cityKey] = [city]
            }
        }
    }
}

