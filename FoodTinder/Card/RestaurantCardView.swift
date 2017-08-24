//
//  RestaurantCardView.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/22/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit

class RestaurantCardView: UIView {
    
    @IBOutlet weak var cardView: NSObject!
    
//    var restaurant: BuisnessClass
//    init(buisness:BuisnessClass){
//        self.restaurant = buisness
//    }
    
    @IBOutlet weak var label: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCard()
    } 
//
    private func setupCard(){
    }

}
