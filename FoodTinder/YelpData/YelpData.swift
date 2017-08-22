//
//  YelpData.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/18/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import Foundation

struct YelpData : Codable{
    var businesses : [businesses]
}
struct region : Codable{
    var center: center
}
struct center : Codable{
    var latitude:Float
    var longitude:Float
}

struct businesses : Codable {
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
    
}
