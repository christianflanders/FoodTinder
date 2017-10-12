//
//  Alerts.swift
//  FoodTinder
//
//  Created by Christian Flanders on 8/26/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import Foundation
import UIKit
//Helper functions to easily create alerts

func presentAlertWithClosure(title: String, message:String, view: UIViewController, completion: @escaping (UIAlertAction) -> ()) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: title, style: .default, handler: completion)
    alert.addAction(action)
    view.present(alert, animated: true, completion: nil)
}
func presentAlert(title: String, message:String, view: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: title, style: .default, handler: nil)
    alert.addAction(action)
    view.present(alert, animated: true, completion: nil)
}
