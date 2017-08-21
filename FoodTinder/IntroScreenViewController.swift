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

class IntroSceneViewController: UIViewController, CLLocationManagerDelegate {
    //MARK: Enums
    
    //MARK: Constants
    let locationManager = CLLocationManager()
    
    //MARK: Variables
    
    //MARK: Outlets
    @IBOutlet weak var mainCard: UIViewX!
    @IBOutlet weak var locationTextField: UITextField!
    
    //MARK: Weak Vars
    
    //MARK: Public Variables
    
    //MARK: Private Variables
    private var location: CLLocation?
    private var lattitude = ""
    private var longitude = ""
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animate()
    }
    //MARK: IBActions
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
    
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WaitingScreenViewController
        destinationVC.longitude = longitude
        destinationVC.lattitude = lattitude
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
