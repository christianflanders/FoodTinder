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
    var businesses : [Buisness]
}
struct region : Codable{
    var center: center
}
struct center : Codable{
    var latitude:Float
    var longitude:Float
}

struct Buisness : Codable {
    var name:String
    var rating: Float
    var price: String? 
//    var location: [String?:String?]
    var phone:String
    var distance:Float
    var url:String
    var image_url: String
    var categories: [[String:String]]
    var coordinates: [String:Float]
    var location : location
    var id: String
}
struct location : Codable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String
    var zip_code: String
    var country:String
    var state:String?

}

//    mutating func ratingToImage(){
//        switch rating {
//        case 0:
//            ratingImage = #imageLiteral(resourceName: "extra_large_0")
//        case 1:
//            ratingImage = #imageLiteral(resourceName: "extra_large_1")
//        default:
//            print("ohfuckboys")
//        }
//    }
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
