//
//  ViewController.swift
//  Project2
//
//  Created by Andres Quintero on 7/22/19.
//  Copyright © 2019 Andres Quintero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var games = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //appending all the image names to countries array
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        askQuestion(action: nil)
    }
    
    func askQuestion(action: UIAlertAction!) {
        if games == 10 {
            let ac = UIAlertController(title: "End of the Game!", message: "You had 10 trys. Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "replay", style: .destructive, handler: restart))
            present(ac, animated: true)
        }
        
        
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)//random int from [0,2]
        title = "\(countries[correctAnswer].uppercased())            Score: \(score)"
        
        
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        games += 1
        if sender.tag == correctAnswer {
            score+=1
            title = "Correct"
            
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            score-=1
            title = "Wrong"
            
            let ac = UIAlertController(title: title, message: "Wrong! That is the Flag of \(countries[sender.tag].capitalized)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    
    func restart(action: UIAlertAction!) {
        games = 0
        score = 0
        askQuestion(action: nil)
    }
    

}

