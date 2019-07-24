//
//  ViewController.swift
//  Project1
//
//  Created by Andres Quintero on 7/19/19.
//  Copyright © 2019 Andres Quintero. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Picture Viewer"
        
        //Large title in Navigation Controller
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // this vc is expecting a UIViewController object as return type but we need a DetailViewController
        //so we are typecasting it (using as?) to a DetailViewController, which is what we want
        // if typecasting does not work then do NOTHING
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            //if typecasting works the run everything in the braces.
            
            //vc is the DetailViewController object which has a selectedImage properites
            //which we are setting to a picture
            vc.selectedImage = pictures[indexPath.row]
            
            // For the challenge: DetailView shows "X of Y" title
            vc.totalOfImages = pictures.count
            vc.indexOfImage = indexPath.row
            
            
            //pushes vc onto a stack
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

