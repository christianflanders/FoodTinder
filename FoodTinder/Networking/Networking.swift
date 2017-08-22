//
//  Networking.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/18/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//
//34.1870
//-118.3813
import Foundation

func requestURL(lattitude: String, longitude:String, completion: @escaping (YelpData) -> Void){
    let search = "https://api.yelp.com/v3/businesses/search?latitude=\(lattitude)&longitude=\(longitude)&term=food"
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
