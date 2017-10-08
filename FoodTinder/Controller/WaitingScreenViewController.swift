//
//  WaitingScreenViewController.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/20/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class WaitingScreenViewController: UIViewController {
    //MARK: Enums
    
    //MARK: Constants
    
    //MARK: Variables
    
    //MARK: Outlets
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var workingLabel: UILabel!
    @IBOutlet weak var activity: NVActivityIndicatorView!
    
    //MARK: Weak Vars
    
    //MARK: Public Variables
    var longitude = ""
    var lattitude = ""
    var distanceInMiles = "10"
    
    //MARK: Private Variables
    private var businessArray = [Buisness]()
    private var imageArray = [UIImage]()
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.type = .orbit
        activity.startAnimating()
        //Grabbing all of our data from Yelp
        DispatchQueue.global().async {
        requestRestaurantsFromYelp(lattitude:self.lattitude, longitude:self.longitude, radius: self.distanceInMiles, offset: "0") { data, error in
            if error == nil {
                let data = data!
                for i in 0..<data .businesses.count{
                self.businessArray.append(data.businesses[i])
            }
            self.imageArray = downloadAllImagesFor(self.businessArray)
            self.performSegue(withIdentifier: "FinishedDownloadingSegue", sender: nil)
            } else {
                presentAlertWithClosuer(title: "Something went wrong", message: "Try Again", view: self, completion: { action in
                    self.performSegue(withIdentifier: "NetworkingErrorSegue", sender: self)
                })
                
            }
        }
        }
        print("latitude is \(lattitude) and longitude is \(longitude)")
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: IBActions
    
    
    //MARK: Instance Methods

 

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "FinishedDownloadingSegue" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let destination = destinationNavigationController.topViewController as! SwipingScreenViewController
            destination.buisnessArray = businessArray
            destination.imageArray = imageArray
            destination.lattitude = lattitude
            destination.longitude = longitude
            
            //send ayelp data obver to next view controller
        }
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
 
    
}
