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
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var getFromLocationButton: UIButton!
    @IBOutlet weak var distanceStaticLabel: UILabel!
    
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
        self.locationTextField.delegate = self
        animate()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
            presentAlert(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.", view: self)
            return
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func goButton(_ sender: Any) {
        if lattitude != "" && longitude != "" {
            performSegue(withIdentifier: "LocationEnteredSegue", sender: view)
        } else if locationTextField.text?.count != 0{
            print("text entered!")
            let text = locationTextField.text
            geocoder.geocodeAddressString(text!) { (placemarks, error) in
                self.processResponse(withPlacemarks: placemarks, error:error)
                self.hideAll()
                self.performSegue(withIdentifier: "LocationEnteredSegue", sender: self.view)
                
            }
        }
        else {
            presentAlert(title: "No location found", message: "No valid location found, please try again",view: self)
        }
    }
    
    //MARK: Instance Methods
    func hideAll(){
        locationTextField.alpha = 0
        distanceSlider.alpha = 0
        distanceSlider.alpha = 0
        distanceLabel.alpha = 0
        goButton.alpha = 0
        getFromLocationButton.alpha = 0
        distanceStaticLabel.alpha = 0
    }
    //Called when the text field is finished typing, sends the contents to the geocoder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        geocoder.geocodeAddressString(textField.text!) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error:error)
        }
        self.view.endEditing(true)
        return false
    }
    func animate(){
        //        mainCard.transform = CGAffineTransform(scaleX: 0, y: 0)
        //        UIViewX.animate(withDuration: 0.7, animations: {
        //            self.mainCard.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        //            })
    }
    //User location to coordinates
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            print("Unable to Find Location for Address")
            
        } else {
            var location: CLLocation?
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            if let location = location {
                let coordinate = location.coordinate
                longitude = String(coordinate.longitude)
                lattitude = String(coordinate.latitude)
            } else {
                print("No Matching Location Found")
            }
        }
    }
    
    
    //MARK: TextField Stuff
    //When user enters a location, and presses the done button, 
    func locationToString(lat: Double, long: Double){
        let location = CLLocation(latitude: lat, longitude: long)
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemark, error) in
            let location = placemark?.first
            let address = location?.thoroughfare ?? "address"
            let city = location?.locality ?? "city"
            let state = location?.administrativeArea ?? "state"
            let zip = location?.postalCode ?? "zipcode"
            self.locationTextField.text = "\(address), \(city), \(state), \(zip)"
        }
        )
    }
    
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WaitingScreenViewController
        destinationVC.longitude = longitude
        destinationVC.lattitude = lattitude
        destinationVC.distanceInMiles = distance
        locationManager.stopUpdatingLocation()
        hideAll()
    }
    
    // MARK: Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        presentAlert(title: "Something went wrong!", message: "Try again", view: self)
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
            locationToString(lat: location.coordinate.latitude, long: location.coordinate.longitude)
            
        }
    }
}
