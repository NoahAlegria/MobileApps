//
//  ViewController.swift
//  lab5coreData
//
//  Created by user144566 on 10/18/18.
//  Copyright © 2018 user144566. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var cityList:cities =  cities()
    
    @IBOutlet weak var cityTable: UITableView!
    let picker = UIImagePickerController()
    var passedName : String?
    var passedDesc : String?
    var imageSelected : UIImage!
    var isValid = false
    var cityModel : CityModel = CityModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityModel.fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        cell.layer.borderWidth = 1.0
        
        let rowData = cityModel.getCityObject(row: indexPath.row)
        cell.cityTitle?.text = rowData.cityName
        cell.cityDescription.text = rowData.cityDescription
        if rowData.cityImage != nil {
            let imgData = rowData.cityImage
            if let image = UIImage(data: imgData! as Data) {
                cell.cityImage.image = image
                
            }
        }
        
        
        return cell
        
    }
    
    // delete table entry
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
        //cityList.cities.remove(at: indexPath.row)
            cityModel.removeCity(row: indexPath.row)
            cityTable.reloadData()
        
        }
    }
    
    // add a new fruit to the fruit table
    @IBAction func refresh(_ sender: AnyObject) {
        
        
        let alert = UIAlertController(title: "Add New City", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name"
        })
        
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "Enter Description"
            
        })
        
        alert.addAction(UIAlertAction(title: "Use Camera", style: .default, handler: { action in
            
            let name = (alert.textFields?.first?.text)!
            let desc = (alert.textFields?.last?.text)!
            if !(name.isEmpty), !(desc.isEmpty) {
                print("New City: \(name)")
                self.passedName = (alert.textFields?.first?.text)!
                self.passedDesc = (alert.textFields?.last?.text)!
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.picker.allowsEditing = false
                    self.picker.sourceType = UIImagePickerController.SourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.picker.modalPresentationStyle = .fullScreen
                    self.present(self.picker,animated: true,completion: nil)
                    self.isValid = true
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            
            if !((alert.textFields?.first?.text)!.isEmpty),
                !((alert.textFields?.last?.text)!.isEmpty){
                self.passedName = (alert.textFields?.first?.text)!
                self.passedDesc = (alert.textFields?.last?.text)!
                print("New City: \(self.passedName)")
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        print("touched")
        picker .dismiss(animated: true, completion: nil)
        imageSelected=info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if (isValid) {
            cityModel.addCity(name: passedName!, desc: passedDesc!, img: imageSelected)
        }
        self.cityTable.reloadData()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cityTable.rowHeight = 85
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        //let city = cityList.cities[selectedIndex.row]
        let newCity = cityModel.getCityObject(row: selectedIndex.row)
        
        
        
        if(segue.identifier == "detailView"){
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.citySelected = newCity
            }
        }
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        cityModel.deleteAll()
        cityTable.reloadData()
        print("All Deleted")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

