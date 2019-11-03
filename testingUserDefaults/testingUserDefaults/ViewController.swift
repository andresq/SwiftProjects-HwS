//
//  ViewController.swift
//  testingUserDefaults
//
//  Created by Andres Quintero on 11/3/19.
//  Copyright © 2019 Andres Quintero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        
        defaults.set("Andres Quintero", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")

        let dict = ["Name": "Andres", "Country": "US"]
        defaults.set(dict, forKey: "SavedDict")
        
        //if saved array exists then return it AND typecast it as a [String] else make a new empty String array
        let newArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        let newDict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
        
        print(newArray)
        print(newDict)
        
    }


}

