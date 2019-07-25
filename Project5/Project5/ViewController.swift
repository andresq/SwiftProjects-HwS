//
//  ViewController.swift
//  Project5
//
//  Created by Andres Quintero on 7/25/19.
//  Copyright © 2019 Andres Quintero. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        let customBarItem = UIBarButtonItem(title: "New Word", style: .plain, target: self, action: #selector(startGame))
        navigationItem.leftBarButtonItem  = customBarItem
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
                allWords.removeLast()
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
        
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    

    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if lowerAnswer == title! {
            showErrorMessage(errorTitle: "Same as title", errorMessage: "Using the title is cheating!")
            return
        }
        if lowerAnswer.count < 3 {
            showErrorMessage(errorTitle: "Answer too short", errorMessage: "Guesses have to be more that 2 letters")
            return
        }
        
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return //needed or else error message will pop up
                } else {
                    showErrorMessage(errorTitle: "Word no recongized", errorMessage: "You can't just make up words!")
                }
            } else {
                showErrorMessage(errorTitle: "Word used already!", errorMessage: "Use an original word")
            }
        } else {
            guard let title = title?.lowercased() else { return }
            showErrorMessage(errorTitle: "Word is not possible", errorMessage: "You can't get \(answer) from \(title)")
        }
    }
    

    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) { //checks that letter is in the word
                tempWord.remove(at: position) // makes sure that said letter is used only once
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        // creates a range for rangeOfMisspelledWord, here we want the whole word
        // use utf16.count when using Apple Frameworks
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        // misspelledRange.location returns the range of the misspelling,
        // however, if the there is no misspelling, there is no range, therefore it returns NSNotFound
        return misspelledRange.location == NSNotFound
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }


}

