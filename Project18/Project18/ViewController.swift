//
//  ViewController.swift
//  Project18
//
//  Created by Andres Quintero on 1/28/20.
//  Copyright © 2020 Andres Quintero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // This loads after the loop from 1 -> 100?
        // even though it is before
        let testLabel = UILabel()
        testLabel.backgroundColor = .systemPurple
        testLabel.text = "andres"
        testLabel.textAlignment = .center
        view.addSubview(testLabel)
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        testLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        testLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        for i in 1 ... 100 {
            print("Got number \(i)")
        }
    }


}

