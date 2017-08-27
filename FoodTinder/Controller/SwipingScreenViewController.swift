//
//  SwipingScreenViewController.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/19/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit

class SwipingScreenViewController: UIViewController {
    //MARK: Enums
    
    //MARK: Constants

    //MARK: Variables
    
    //MARK: Outlets
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCatagoriesLabel: UILabel!
    @IBOutlet weak var restaurantPriceLabel: UILabel!
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    @IBOutlet weak var restaurantStarsImage: UIImageView!
    
    //MARK: Weak Vars
    
    //MARK: Public Variables
    var originalPosition = CGPoint()
    var buisnessArray = [Buisness]()
    var imageArray = [UIImage]()
    var lattitude = ""
    var longitude = ""
    
    //MARK: Private Variables
    private var currentNum = 0
    private var divisor: CGFloat!
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateDisplay()
        divisor = (view.frame.width / 2) / 0.61
        originalPosition = cardContainerView.center
        
    }
    //MARK: IBActions
    @IBAction func dislikeButton(_ sender: UIButton){
        dislikeRestaurant()
    }

    
    @IBAction func backButton(_ sender: UIButton) {
        if currentNum != 0 {
            currentNum -= 1
        }
        updateDisplay()
        }
    
    @IBAction func likeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "RestaurantSelectedSegue", sender: self)

    }
    
    
    
    //MARK: Gestures
    //FIXME: When card is returned to middle, it shound't be turned
    
    fileprivate func dislikeRestaurant() {
        if currentNum < buisnessArray.count - 1 {
            currentNum += 1
            updateDisplay()
        } else {
            presentAlert(title: "Reached the end!", message: "Reached The End Of The List",view: self)
        }
        if currentNum == 25 {
            addMoreRestaurantsToList()
        }
    }
    
    fileprivate func dislikeRestaurantCard(_ card: UIView) {
        print(buisnessArray.count)
        dislikeRestaurant()
        UIView.animate(withDuration: 0.3, animations: {
            card.center = CGPoint(x: card.center.x - 400 , y: card.center.y + 75)
            card.transform = CGAffineTransform(scaleX: 0, y: 0)
            card.alpha = 0
        })
        updateDisplay()
        card.center = self.originalPosition
        UIView.animate(withDuration: 0.3, animations: {
            card.alpha = 1
            card.transform = CGAffineTransform(scaleX: 1, y:  1)
        })
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        cardContainerView.center.x = sender.location(in: self.view).x
        let xFromCenter = card.center.x - view.center.x
        let direction = sender.translation(in: view)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor)
  
        if sender.state == UIGestureRecognizerState.ended {
            if direction.x < -80  {
                dislikeRestaurantCard(card)
                card.transform = CGAffineTransform(scaleX: 0, y: 0)
                UIView.animate(withDuration: 0.3, animations: {
                    card.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            } else if direction.x > 80 {
                UIView.animate(withDuration: 0.3, animations: {
                    })
                performSegue(withIdentifier: "RestaurantSelectedSegue", sender: self)
            } else {
            }
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.originalPosition
                card.transform = CGAffineTransform(rotationAngle: 0)
            })
            print(direction)

        }
    }
    
    
    //MARK: Instance Methods
    func dislike(){
        
    }

    func updateDisplay() {
        let currentRestaurant = buisnessArray[currentNum]
        restaurantNameLabel.text = currentRestaurant.name
        restaurantStarsImage.image = ratingToImage(rating: currentRestaurant.rating)
        let distanceInMiles = String(format: "%.2f",currentRestaurant.distance * 0.0006214)
        restaurantDistanceLabel.text = "\(distanceInMiles) miles away"
        let categories = currentRestaurant.categories
        let one = categories[0]["title"] ?? ""
        //TODO: Add in funcitonality to check how many categories there are and display them. For now we'll just display one
        //        let two = categories[1]["title"] ?? ""
        if imageArray.count != 0 {
            restaurantImageView.image = imageArray[currentNum]
            }
        let categoriesDescription = "\(one)"
        restaurantCatagoriesLabel.text = categoriesDescription
//        restaurantPriceLabel.text = currentRestaurant.price
        if let price = currentRestaurant.price {
            restaurantPriceLabel.text = String(price)

        }
        
    }

    
    func getImage() -> UIImage{
        var image = UIImage()
        let url = URL(string:buisnessArray[currentNum].image_url)
        let data = try? Data(contentsOf: url!)
        image = UIImage(data: data!)!
        return image
        
    }
    func downloadAllImages()-> [UIImage]{
        var allImages = [UIImage]()
        
            for i in 0..<self.buisnessArray.count{
                let url = URL(string:self.buisnessArray[i].image_url)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)!
                allImages.append(image)
            }
        return allImages
    }
    
    private func addMoreRestaurantsToList() {
        requestRestaurantsFromYelp(lattitude:lattitude, longitude:longitude, radius: "10000", offset:"50") { data in
            //            yelpData = data
            print("getting new restaurants")
            DispatchQueue.global().async {
                for i in 0..<data.businesses.count{
                    self.buisnessArray.append(data.businesses[i])
                    self.imageArray.append(downloadImagesForRestaurant(data.businesses[i]))
                }
            }
        }
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RestaurantSelectedSegue" {
            print("segue identifier found")
            let destination = segue.destination as! RestaurantSelectionScreenViewController
            let currentRestaurant = buisnessArray[currentNum]
            destination.coordinates["latitude"] = currentRestaurant.coordinates["latitude"]
            destination.coordinates["longitude"] = currentRestaurant.coordinates["longitude"]
            destination.restaurantLocation = currentRestaurant.location
            destination.restorationIdentifier = currentRestaurant.id
            destination.restaurantName = currentRestaurant.name
            destination.restaurantURL = currentRestaurant.url
            destination.restaurantPhoneNum = currentRestaurant.phone
            destination.restaurantID = currentRestaurant.id
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
