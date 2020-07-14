//
//  ViewController.swift
//  Project22
//
//  Created by Andres Quintero on 7/14/20.
//  Copyright © 2020 Andres Quintero. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet var distanceReading: UILabel!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) { //  is beacon a feature on this device
                if CLLocationManager.isRangingAvailable() { // Ranging: means if our device is able to tell how far away something is
                    // We are okay to start doing beacon stuff
                    startScanning()
                    
                }
            }
        }
    }
    
    func startScanning() {
        // This uuid is a testing string from apple
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegoin = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
    
        
        locationManager?.startMonitoring(for: beaconRegoin) // tell iOS to look for beacon
        locationManager?.startRangingBeacons(in: beaconRegoin) // tells iOS to let us how far/near it is
    }
    
    func update(distance: CLProximity) { // UI Changes here
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = UIColor.blue
                self.distanceReading.text = "FAR"

            case .near:
                self.view.backgroundColor = UIColor.orange
                self.distanceReading.text = "NEAR"

            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.distanceReading.text = "RIGHT HERE"
            default: // This catches Unkown as well
                self.view.backgroundColor = UIColor.gray
                self.distanceReading.text = "UNKNOWN"
            }
        }
    }
    
    
    // This catches the ranging of the FIRST beacon in the array (could be mutliple with same UUID, but we focus on the first one)
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }


}

