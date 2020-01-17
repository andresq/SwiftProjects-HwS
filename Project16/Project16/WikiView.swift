//
//  WikiView.swift
//  Project16
//
//  Created by Andres Quintero on 1/16/20.
//  Copyright © 2020 Andres Quintero. All rights reserved.
//

import UIKit
import WebKit

class WikiView: UIViewController {
    let wikiView = WKWebView()
    var wiki = "https://en.wikipedia.org/wiki/"
    var city = "Apple_Inc." // Default
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = wiki+city
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        wikiView.load(urlRequest)
        print(urlString)
        
        //setting up contraints
        wikiView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wikiView)
        wikiView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        wikiView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        wikiView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        wikiView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }

}
