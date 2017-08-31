//
//  RestaurantSelectedViewController.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/22/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit
import MapKit
class RestaurantSelectionScreenViewController: UIViewController {
    //MARK: Enums
    
    //MARK: Constants
    
    //MARK: Variables
    //MARK: Outlets
    
    //MARK: Weak Vars
    
    //MARK: Public Variables
    var coordinates: [String:Float] = ["latitude": 4.20, "longitude": 6.9]
    var restaurantLocation: location?
    var restaurantName = ""
    var restaurantURL = ""
    var restaurantPhoneNum = ""
    var restaurantID = ""
    //MARK: Private Variables
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(restaurantName)
        print(coordinates)
        print("Location decoded and sent" , restaurantLocation)
    }

    //MARK: IBActions
    @IBAction func openInYelp(_ sender: UIButton) {
        print(restaurantID)
        let url = URL(string: "yelp:///biz/\(restaurantID)")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func goNowButton(_ sender: UIButton) {
        let latitudeDegrees:CLLocationDegrees = CLLocationDegrees(coordinates["latitude"]!)
        let longitudeDegrees: CLLocationDegrees = CLLocationDegrees(coordinates["longitude"]!)
        let regionDistance: CLLocationDistance = 1000
        let coordinatesFromDegrees = CLLocationCoordinate2DMake(latitudeDegrees, longitudeDegrees)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinatesFromDegrees, regionDistance, regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan:regionSpan.span)]
        let address1 = (restaurantLocation?.address1)!
        let city = (restaurantLocation?.city)!
        let zipcode = (restaurantLocation?.zip_code)!
        let country = (restaurantLocation?.country)!
        let state = (restaurantLocation?.state)!
        let addressDict = ["street":address1,"city":city,"postalcode":zipcode,"country":country,"state":state]
        let placemark = MKPlacemark(coordinate: coordinatesFromDegrees,addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = restaurantName
        mapItem.openInMaps(launchOptions: options)
    }
        @IBAction func goBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func callButton(_ sender: UIButton) {
            print(restaurantPhoneNum)
        let url = URL(string: "tel:\(restaurantPhoneNum)")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
    //MARK: Instance Methods
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

