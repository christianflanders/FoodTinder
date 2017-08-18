//
//  ViewController.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/17/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct YelpData : Codable{
        let businesses : [businesses]
    }
    struct region : Codable{
        let center: center
    }
    struct center : Codable{
        let latitude:Float
        let longitude:Float
    }
    
    struct businesses : Codable {
        var name:String
        var rating: Float
        var price: String
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func requestURL(){
        let search = "https://api.yelp.com/v3/businesses/search?latitude=34.1870&longitude=-118.3813"
        let url = URL(string: search)!
        var request = URLRequest(url: url)
        request.addValue("Bearer zJ5EZr0SjMEw7Q87joFLti8KJF9GamdrJzYWuSG7C5hB_fxgM36jBwDfut0bXXYRf9Gikapdkh66PNxECfl6SMb35TAc9ybB3DxepQkGW3KqUxEgQyBf6tgUFB6WWXYx ", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, err)  in
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(YelpData.self, from: data)
                print(decoded)
            } catch let jsonErr {
                print("error serializing json:", jsonErr)
            }
            
        }.resume()
}
//dictionary with an key of string, with a value of an array of dictionaries with a key of string
}
