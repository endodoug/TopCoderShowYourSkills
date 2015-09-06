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
    
    // MARK: Location methods
    
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
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
        
        locationLabel.text = "\(placemark.locality)" + " " + "\(placemark.administrativeArea) "
        
    }
    
    // MARK: Submit Button Tapped

    @IBAction func submitButtonTapped(sender: UIButton) {
        
        var tempature: Double = NSString(string: bodyTempatureTextField.text).doubleValue
        if tempature == 0 {
            bodyTempatureSubmittedLabel.text = "Please enter a valid number."
        } else {
            bodyTempatureSubmittedLabel.text = "\(tempature)"
        }

        submittedDispositionLabel.text = dispositionTextField.text
        locationSubmittedLabel.text = locationLabel.text
        
        // display submitted label
        bodyTempatureSubmittedLabel.hidden = false
        submittedDispositionLabel.hidden = false
        locationSubmittedLabel.hidden = false
        
        removeKeyboard()
    }
    
    // MARK: hide keyboard
    
    func removeKeyboard () {
        bodyTempatureTextField.resignFirstResponder()
        dispositionTextField.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        bodyTempatureTextField.endEditing(true)
        dispositionTextField.endEditing(true)
    }

}

