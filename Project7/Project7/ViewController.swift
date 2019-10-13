//
//  ViewController.swift
//  Project7
//
//  Created by Andres Quintero on 9/23/19.
//  Copyright © 2019 Andres Quintero. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // aparently this is needed because typing "Cell" in Identifier does not work anymore?
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        //adding async()
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(json: data)
                    return
                }
            }
            self.showError() // showError() needs to be in GCD else it would always run; however it updates UI so it's code needs to run in main thread
                             // this is fixed in function declaration. (wrapping the code in a main thread)
        }

    }
    
    // parse functions
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            DispatchQueue.main.async {
                self.tableView.reloadData() //updates UI with new data
            }
        }
    }
    
    
    // tableView methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    //moving to detailViewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row] //here we are passing the petition selected in this VC to the DetailVC's detailItem property
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // error if json data is not loaded
    func showError() {
        DispatchQueue.main.async { //showError() needs to be in main thread because showError() is updateing UI; which is ALWAYS done on the main thread
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    


}

