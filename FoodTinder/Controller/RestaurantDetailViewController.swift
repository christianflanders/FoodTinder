//
//  RestaurantDetailViewController.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/30/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    //MARK: Enums
    
    //MARK: Constants
    
    //MARK: Variables
    var selectedRestaurant: Buisness?
    //MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var displayAddressLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    //MARK: Weak Vars
    
    //MARK: Public Variables
    
    //MARK: Private Variables
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedRestaurant)
        if selectedRestaurant != nil{
            updateDisplay()
            
        }
    }
    
    func updateDisplay() {
        let currentRestaurant = selectedRestaurant!
        nameLabel.text = currentRestaurant.name
        ratingImage.image = ratingToImage(rating: currentRestaurant.rating)
        let distanceInMiles = String(format: "%.2f",currentRestaurant.distance * 0.0006214)
        distanceLabel.text = "\(distanceInMiles) miles away"
        let categories = currentRestaurant.categories
        let one = categories[0]["title"] ?? ""
        //TODO: Add in funcitonality to check how many categories there are and display them. For now we'll just display one
        //        let two = categories[1]["title"] ?? ""
//        if imageArray.count != 0 {
//            restaurantImage.image = imageArray[currentNum]
//        }
        let categoriesDescription = "\(one)"
        categoriesLabel.text = categoriesDescription
        //        restaurantPriceLabel.text = currentRestaurant.price
        if let price = currentRestaurant.price {
            priceLabel.text = String(price)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: IBActions
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
