//
//  ViewController.swift
//  Project16
//
//  Created by Andres Quintero on 1/16/20.
//  Copyright © 2020 Andres Quintero. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    let myFavGreen = UIColor(red: 62/255, green: 201/255, blue: 138/255, alpha: 1.0)
    var counter = 1 {
        didSet {
            if counter == 5 {
                print("Counter is at \(counter)")
                navigationController?.navigationBar.barTintColor = myFavGreen
                navigationItem.rightBarButtonItem?.tintColor = .black
            }
        }
    }
    // SF Symbols fun
    let rightButtonIcon = UIImage(named: "number")
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Capitals and NYC
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        let nyc = Capital(title: "New York City", coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), info: "America's first capital")

        
        // Adding the capitals (which are MKAnnotations) to the map
        mapView.addAnnotations([london, oslo, paris, rome, washington, nyc])
        
        // Random mapTypes
//        let mapTypes = [MKMapType.hybrid, .hybridFlyover, .mutedStandard, .satellite, .satelliteFlyover, .standard]
//        mapView.mapType = mapTypes.randomElement()!
        
        // SF Symbols Fun
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightButtonIcon, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(boop))
        navigationItem.rightBarButtonItem?.tintColor = .systemPink
        
    }
    
    
    // MapView Delegate Methods
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //1
        guard annotation is Capital else {return nil}
        
        //2
        let identifier = "Capital"
        
        //3
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        
        if annotationView == nil {
            //4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            //5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
        } else {
            //6
            annotationView?.annotation = annotation
        }
        
        annotationView?.tintColor = myFavGreen
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
//        let placeName = capital.title
//        let placeInfo = capital.info
//
//
//
//
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(ac, animated: true)
        
        
        let placeName = capital.title?.replacingOccurrences(of: " ", with: "_") // Because wiki URL do not have spaces
        let newView = WikiView()
        newView.city = placeName ?? "Apple_Inc."
        
        navigationController?.pushViewController(newView, animated: true)
    }
    
    @objc func boop() {
        print("The counter is at \(counter)")
        
       
        
        
        if counter % 20 == 0 {
            let ac = UIAlertController(title: "Stop!", message: "You've hit the button \(counter) times", preferredStyle:  .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        }
        
        
        
        
        
        
        counter += 1
    }


}

