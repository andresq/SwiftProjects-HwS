//
//  DetailViewController.swift
//  Project1
//
//  Created by Andres Quintero on 7/19/19.
//  Copyright © 2019 Andres Quintero. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //selectedImage is 'sent' from ViewController
    var selectedImage: String?
    var totalOfImages: Int?
    var indexOfImage: Int?
    @IBOutlet var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title is nil which is not displaying a title by default
        // no need to unwrap it becase worse case we set nil = nil and that produces the deafult of no title displayed
        //title = selectedImage
        
        if let x = indexOfImage, let y = totalOfImages {
            title = "\(x+1) of \(y)"
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        //Makes sure that title is never shown large
        navigationItem.largeTitleDisplayMode = .never
        
        
        
        if let imageToLoad = selectedImage {
            
            imageView.image = UIImage(named: imageToLoad)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
