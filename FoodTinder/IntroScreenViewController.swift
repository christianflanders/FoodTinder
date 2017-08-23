//
//  IntroScreenViewController.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/19/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class IntroSceneViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    //MARK: Enums
    
    //MARK: Constants
    let locationManager = CLLocationManager()
    let address = ""
    let geocoder = CLGeocoder()
    //MARK: Variables
    
    //MARK: Outlets
    @IBOutlet weak var mainCard: UIViewX!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    
    //MARK: Weak Vars
    
    //MARK: Public Variables
    
    //MARK: Private Variables
    private var location: CLLocation?
    private var lattitude = ""
    private var longitude = ""
    private var distance = ""
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.locationTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animate()
    }
    //MARK: IBActions
    @IBAction func distanceSliderAction(_ sender: UISlider) {
        let distanceInMiles = String(format: "%2.0f",sender.value)
        let distanceInMeters = String(format: "%2.0f",sender.value * 1609.34)
        print(distanceInMeters)
        distance = distanceInMeters
        distanceLabel.text = "\(distanceInMiles) miles"
        print(sender.value)
    }
    @IBAction func getLocationButton(_ sender: UIButton) {
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    //MARK: Instance Methods
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
    func animate(){
        mainCard.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIViewX.animate(withDuration: 0.7, animations: {
            self.mainCard.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
    }

    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled",
                                      message:
            "Please enable location services for this app in Settings.",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default,
                                     handler: nil)
        present(alert, animated: true, completion: nil)
        alert.addAction(okAction)
    }
    
    func userEnteredAddress(address:String){
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks,error) -> Void in
            if ((error) != nil){
                print("Error converting string to location",error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                print(coordinates)
            }
            
            
        })
    }
    
    //MARK: TextField Stuff
    //When user enters a location, and presses the done button, 
    
    
    
    
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WaitingScreenViewController
        destinationVC.longitude = longitude
        destinationVC.lattitude = lattitude
        destinationVC.distanceInMiles = distance
        locationManager.stopUpdatingLocation()
     }
 
    // MARK: Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error \(error))")
    }
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        print("didUpdateLocations \(newLocation)")
        location = newLocation
        if let location = location {
            lattitude = String(format: "%.8f", location.coordinate.latitude)
            longitude = String(format: "%.8f", location.coordinate.longitude)
            locationTextField.text = "Lattitude: \(lattitude), Longitude: \(longitude)"
        }
    }
}
