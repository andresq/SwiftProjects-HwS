//
//  Person.swift
//  Project10
//
//  Created by Andres Quintero on 10/14/19.
//  Copyright © 2019 Andres Quintero. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name;
        self.image = image;
    }

}
