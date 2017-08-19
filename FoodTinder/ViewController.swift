//
//  ViewController.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/17/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    var buisnessArray = [businesses]()
    var currentNum = 0
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var catagoriesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        var yelpData = YelpData(businesses: buisnessArray)
        requestURL { data in
            yelpData = data
            for i in 0..<data.businesses.count{
                self.buisnessArray.append(data.businesses[i])
            }
            self.updateDisplay()
        }
        
        super.viewDidLoad()
    }
    func updateDisplay() {
        nameLabel.text = buisnessArray[currentNum].name
        let categories = buisnessArray[currentNum].categories
        let one = categories[0]["title"] ?? ""
        //TODO: Add in funcitonality to check how many categories there are and display them. For now we'll just display one
//        let two = categories[1]["title"] ?? ""
        DispatchQueue.global().async {
            let image = self.getImage()
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        let categoriesDescription = "\(one)"
        catagoriesLabel.text = categoriesDescription
        print(categoriesDescription)

    }

    func getImage() -> UIImage{
        var image = UIImage()
        let url = URL(string:buisnessArray[currentNum].image_url)
        let data = try? Data(contentsOf: url!)
        image = UIImage(data: data!)!
        return image

    }
    @IBAction func nextButton(_ sender: UIButton) {
        print(buisnessArray.count)
        if currentNum < buisnessArray.count - 1 {
            currentNum += 1
            updateDisplay()
        } else {
            print("reached end!")
        }
    }
    @IBAction func backButton(_ sender: UIButton) {
        if currentNum != 0 {
            currentNum -= 1
        }
        updateDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func requestURL(completion: @escaping (YelpData) -> Void){
        let search = "https://api.yelp.com/v3/businesses/search?latitude=34.1870&longitude=-118.3813"
        let url = URL(string: search)!
        var request = URLRequest(url: url)
        request.addValue("Bearer zJ5EZr0SjMEw7Q87joFLti8KJF9GamdrJzYWuSG7C5hB_fxgM36jBwDfut0bXXYRf9Gikapdkh66PNxECfl6SMb35TAc9ybB3DxepQkGW3KqUxEgQyBf6tgUFB6WWXYx ", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, err)  in

            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(YelpData.self, from: data) as YelpData
                DispatchQueue.main.async {
                    completion(decoded)
                }
            
//                print(decoded)
            } catch let jsonErr {
                print("error serializing json:", jsonErr)
            }
            
        }.resume()
}
//dictionary with an key of string, with a value of an array of dictionaries with a key of string
}
