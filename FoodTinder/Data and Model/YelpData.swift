//
//  YelpData.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/18/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import Foundation
import UIKit

struct YelpData : Codable{
    let businesses : [Buisness]
}

struct Buisness : Codable {
    let name:String
    let rating: Float
    let price: String?
//    var location: [String?:String?]
    let phone:String
    let distance:Float
    let url:String
    let image_url: String
    let categories: [[String:String]]
    let coordinates: [String:Float]
    let location : location
    let id: String
}
struct location : Codable {
    let address1: String?
    let address2: String?
    let address3: String?
    let city: String
    let zip_code: String
    let country:String
    let state:String?

}


func ratingToImage(rating:Float)-> UIImage {
    var ratingImage = UIImage()
            switch rating {
            case 0:
                ratingImage = #imageLiteral(resourceName: "extra_large_0")
            case 1:
                ratingImage = #imageLiteral(resourceName: "extra_large_1")
            case 1.5:
                ratingImage = #imageLiteral(resourceName: "extra_large_1_half")
            case 2:
                ratingImage = #imageLiteral(resourceName: "extra_large_2")
            case 2.5:
                ratingImage = #imageLiteral(resourceName: "extra_large_2_half")
            case 3:
                ratingImage = #imageLiteral(resourceName: "extra_large_3")
            case 3.5:
                ratingImage = #imageLiteral(resourceName: "extra_large_3_half")
            case 4:
                ratingImage = #imageLiteral(resourceName: "extra_large_4")
            case 4.5:
                ratingImage = #imageLiteral(resourceName: "extra_large_4_half")
            case 5:
                ratingImage = #imageLiteral(resourceName: "extra_large_5")
            default:
                print("Rating image not found")
    }
    return ratingImage
}
