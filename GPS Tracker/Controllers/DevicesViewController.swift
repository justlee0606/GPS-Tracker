//
//  DevicesViewController.swift
//  GPS Tracker
//
//  Created by Justin Lee on 9/17/20.
//  Copyright © 2020 Justin Lee. All rights reserved.
//

import UIKit
import Firebase

class DevicesViewController: SwipeTableViewController {
    
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    var deviceArray: [Device] = []
    let currentUID = (Auth.auth().currentUser?.uid)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = deviceArray[indexPath.row].name
        return cell
    }
    
    //Add new device to the device array and to Firebase
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var deviceNameField = UITextField()
        var devicePINField = UITextField()
        
        let alert = UIAlertController(title: "Add A New Device", message: "", preferredStyle: .alert)
        
        let addDevice = UIAlertAction(title: "Add Device", style: .default) { (action) in
            
            let newDevice = Device(name: deviceNameField.text!, pin: Int(devicePINField.text!)!, lat: 0.0, long: 0.0)
            self.saveNewDevice(device: newDevice)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addTextField { (alertTextField) in
            deviceNameField = alertTextField
            alertTextField.placeholder = "Enter device name"
        }
        
        alert.addTextField { (alertTextField) in
            devicePINField = alertTextField
            alertTextField.placeholder = "Enter device PIN"
        }
        
        alert.addAction(addDevice)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //Edit device array on app and Firebase
    func saveNewDevice(device: Device) {
        deviceArray.append(device)
        let deviceDictionary = ["name" : device.name,
                                "pin" : device.pin,
                                "lat" : device.lat,
                                "long" : device.long] as [String : Any]
        
        db.collection("users").document(currentUID).collection("devices").document(device.name).setData(["Device" : deviceDictionary]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        tableView.reloadData()
    }
    
    //Delete device array on app and Firebase
    override func deleteDevice(at indexPath: IndexPath) {
        db.collection("users").document(currentUID).collection("devices").document(deviceArray[indexPath.row].name).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        deviceArray.remove(at: indexPath.row)
    }
}
