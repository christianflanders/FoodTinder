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
    let alert = UIAlertController()
    //MARK: Variables
    
    //MARK: Outlets
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var restaurantImageView: UIImageViewX!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCatagoriesLabel: UILabel!
    @IBOutlet weak var restaurantPriceLabel: UILabel!
    @IBOutlet weak var restaurantStarsLabel: UILabel!
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    
    //MARK: Weak Vars
    
    //MARK: Public Variables
    var originalPosition = CGPoint()
    var buisnessArray = [businesses]()
    var imageArray = [UIImage]()

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
        originalPosition = cardView.center
        
    }
    //MARK: IBActions
    @IBAction func dislikeButton(_ sender: RoundedButton){
        if currentNum != 0 {
            currentNum -= 1
        }
        updateDisplay()
    }
    @IBAction func likeButton(_ sender: RoundedButton) {
        print(buisnessArray.count)
        if currentNum < buisnessArray.count - 1 {
            currentNum += 1
            updateDisplay()
        } else {
            print("reached end!")
        }
    }
    //MARK: Gestures
    //FIXME: When card is returned to middle, it shound't be turned
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        card.center.x = sender.location(in: self.view).x
        let xFromCenter = card.center.x - view.center.x
//        card.alpha =    view.center.x / abs(xFromCenter)
        let direction = sender.translation(in: view)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor)
        if sender.state == UIGestureRecognizerState.ended {
            if direction.x < -80  {
                dislike()
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 400 , y: card.center.y + 75)
//                    card.transform = CGAffineTransform(scaleX: 0, y: 0)
                    card.alpha = 0
                    
                    })
                updateDisplay()
                card.center = self.originalPosition
                UIView.animate(withDuration: 0.3, animations: {
                    card.alpha = 1
                    card.transform = CGAffineTransform(scaleX: 1, y:  1)
                    })
                return
            } else if direction.x > 80 {
                //TODO: Open link in Yelp online? directions to restaruant
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 400 , y: card.center.y - 75)
                    card.alpha = 0
                    card.transform = CGAffineTransform(rotationAngle: 0)
                })
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.originalPosition
            })
            print(direction)

        }
    }
    
    
    //MARK: Instance Methods
    func dislike(){
        print(buisnessArray.count)
        if currentNum < buisnessArray.count - 1 {
            currentNum += 1
            updateDisplay()
        } else {
            print("reached end!")
        }
    }

    func updateDisplay() {
        print(imageArray)
        restaurantImageView.borderWidth = 0
        let currentRestaurant = buisnessArray[currentNum]
        restaurantNameLabel.text = currentRestaurant.name
        let categories = currentRestaurant.categories
        let one = categories[0]["title"] ?? ""
        //TODO: Add in funcitonality to check how many categories there are and display them. For now we'll just display one
        //        let two = categories[1]["title"] ?? ""
        if imageArray.count != 0 {
            restaurantImageView.image = imageArray[currentNum]
            }
        let categoriesDescription = "\(one)"
        restaurantCatagoriesLabel.text = categoriesDescription
        restaurantPriceLabel.text = currentRestaurant.price
        restaurantPriceLabel.text = String(currentRestaurant.rating)
        print(categoriesDescription)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
