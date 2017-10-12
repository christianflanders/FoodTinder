//
//  Networking.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/18/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import Foundation
import UIKit

//Asks yelps API for a list of restaurants based on our input parameters, parses the JSON, and returns them as a YelpData object.
func requestRestaurantsFromYelp(lattitude: String, longitude:String,radius:String, offset:String, completion: @escaping(YelpData?, Error?) -> Void) {
    print("radius is", radius)
    let search = "https://api.yelp.com/v3/businesses/search?latitude=\(lattitude)&longitude=\(longitude)&term=food&radius=\(radius)&limit=50&offset=\(offset)&sort_by=best_match"
    let url = URL(string: search)!
    var request = URLRequest(url: url)
    request.addValue("Bearer zJ5EZr0SjMEw7Q87joFLti8KJF9GamdrJzYWuSG7C5hB_fxgM36jBwDfut0bXXYRf9Gikapdkh66PNxECfl6SMb35TAc9ybB3DxepQkGW3KqUxEgQyBf6tgUFB6WWXYx ", forHTTPHeaderField: "Authorization")
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, err)  in
        
        guard let data = data else { return }
        do {
            let decoded = try JSONDecoder().decode(YelpData.self, from: data) as YelpData
            DispatchQueue.main.async {
                completion(decoded, nil)
            }
            
            //                print(decoded)
        } catch let jsonErr {
            completion(nil, jsonErr)
            print("error serializing json:", jsonErr)
        }
        
        }.resume()
}

//Give it a list of buisness and it will download the images for that list and return them as an array.
func downloadAllImagesFor(_ businessArray: [Buisness])-> [UIImage]{
    //dotry
    let errorImage = #imageLiteral(resourceName: "errorImage")
    var allImages = [UIImage]()
    for i in 0..<businessArray.count{
        //TODO: Check for valid image
        if let url = URL(string:businessArray[i].image_url) {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                allImages.append(image!)
            } catch {
                allImages.append(errorImage)
            }
        } else {
            allImages.append(errorImage)
        }
    }
    return allImages
}

func downloadImagesForRestaurant(_ business: Buisness)-> UIImage{
    let errorImage = #imageLiteral(resourceName: "errorImage")
    var image = UIImage()
    if let url = URL(string:business.image_url) {
        let data = try? Data(contentsOf: url)
        image = UIImage(data: data!)!
        return image
    } else {
        return errorImage
    }
}

