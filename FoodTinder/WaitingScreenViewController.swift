//
//  WaitingScreenViewController.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/20/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit
class WaitingScreenViewController: UIViewController {
    //MARK: Enums
    
    //MARK: Constants
    
    //MARK: Variables
    
    //MARK: Outlets
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var workingLabel: UILabel!
    
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
        requestURL(lattitude:lattitude, longitude:longitude, radius: distanceInMiles) { data in
            //            yelpData = data
            var progress:Float = 0.0
            for i in 0..<data.businesses.count{
                self.businessArray.append(data.businesses[i])
                progress += Float(0.2)
                self.progressBar.setProgress(progress, animated: true)
            }
            self.imageArray = self.downloadAllImages()
            self.performSegue(withIdentifier: "FinishedDownloadingSegue", sender: nil)
        }
        print("latitude is \(lattitude) and longitude is \(longitude)")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: IBActions
    
    //MARK: Instance Methods
    func downloadAllImages()-> [UIImage]{
        let errorImage = #imageLiteral(resourceName: "errorImage")
        var allImages = [UIImage]()
        for i in 0..<self.businessArray.count{
            if let url = URL(string:self.businessArray[i].image_url) {
            let data = try? Data(contentsOf: url)
            let image = UIImage(data: data!)!
            allImages.append(image)
            } else {
                allImages.append(errorImage)
            }
        }
        return allImages
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "FinishedDownloadingSegue" {
            let destination = segue.destination as! SwipingScreenViewController
            destination.buisnessArray = businessArray
            destination.imageArray = imageArray
            
            //send ayelp data obver to next view controller
        }
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
 
    
}
