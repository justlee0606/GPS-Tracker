//
//  MapViewController.swift
//  GPS Tracker
//
//  Created by Justin Lee on 9/17/20.
//  Copyright © 2020 Justin Lee. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation

class MapViewController: UIViewController{
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var deviceArray: [Device] = []
    var markerArray: [MKPointAnnotation] = []
    let currentUID = (Auth.auth().currentUser?.uid)!
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        refreshButton.layer.cornerRadius = refreshButton.frame.width/2
        centerButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        centerButton.layer.cornerRadius = centerButton.frame.width/2

        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadDevices()
        centerUserLocation()
    }
    
    //Get device array for the user from Firebase
    func loadDevices() {
        clearMap()
        deviceArray.removeAll()
        let collectionRef = db.collection("users").document(currentUID).collection("devices")
        collectionRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let deviceDictionary = data["Device"] as! [String: Any]
                    let pin = deviceDictionary["pin"] as! Int
                    
                    self.ref.child(String(pin)).observeSingleEvent(of: .value, with: { (snapshot) in
                        let value = snapshot.value as! [String: Any]
                        let lat = value["lat"] as! Double
                        let long = value["long"] as! Double
                        let newDevice = Device(name: document.documentID, pin: pin, lat: lat, long: long)
                        self.deviceArray.append(newDevice)
                        
                        DispatchQueue.main.async {
                            self.updateMap(device: newDevice)
                        }
                      }) { (error) in
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
        
    //Send device array to the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DevicesViewController
        destinationVC.deviceArray = deviceArray
    }
    
    //Handle Map UI
    func updateMap(device: Device) {
        let marker = MKPointAnnotation()
        marker.title = device.name
        marker.coordinate = CLLocationCoordinate2D(latitude: device.lat, longitude: device.long)
        mapView.addAnnotation(marker)
        markerArray.append(marker)
    }
    
    func clearMap() {
        for marker in markerArray {
            mapView.removeAnnotation(marker)
        }
        markerArray.removeAll()
    }
    
    func centerUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func centerButtonPressed(_ sender: UIButton) {
        centerUserLocation()
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        loadDevices()
    }
}

