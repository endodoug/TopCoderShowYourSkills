//
//  ViewController.swift
//  TopCoderShowYourSkills
//
//  Created by doug harper on 9/3/15.
//  Copyright (c) 2015 Doug Harper. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var bodyTempatureTextField: UITextField!
    @IBOutlet weak var dispositionTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var bodyTempatureSubmittedLabel: UILabel!
    @IBOutlet weak var submittedDispositionLabel: UILabel!
    @IBOutlet weak var locationSubmittedLabel: UILabel!
    
    let locationManager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyTempatureTextField.delegate = self
        dispositionTextField.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        removeKeyboard()
        return true
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil)
            {
                println("Error: " + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0
            {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }
            else
            {
                println("Error with the data.")
            }
        })
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
    
    func displayLocationInfo (placemark: CLPlacemark) {
        
        self.locationManager.stopUpdatingLocation()
//        println(placemark.locality)
//        println(placemark.postalCode)
//        println(placemark.administrativeArea)
//        println(placemark.country)
        
        locationLabel.text = "\(placemark.locality)" + " " + "\(placemark.administrativeArea) "
        
    }

    @IBAction func submitButtonTapped(sender: UIButton) {
        bodyTempatureSubmittedLabel.text = bodyTempatureTextField.text
        submittedDispositionLabel.text = dispositionTextField.text
        
        // reset text fields
        bodyTempatureTextField.text = ""
        dispositionTextField.text = ""
        locationSubmittedLabel.text = locationLabel.text
        
        removeKeyboard()
        
    }
    
    func removeKeyboard () {
        bodyTempatureTextField.resignFirstResponder()
        dispositionTextField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

