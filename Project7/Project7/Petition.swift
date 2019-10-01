//
//  Petition.swift
//  Project7
//
//  Created by Andres Quintero on 9/23/19.
//  Copyright © 2019 Andres Quintero. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
