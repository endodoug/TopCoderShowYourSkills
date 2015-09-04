//
//  ViewController.swift
//  TopCoderShowYourSkills
//
//  Created by doug harper on 9/3/15.
//  Copyright (c) 2015 Doug Harper. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bodyTempatureTextField: UITextField!
    @IBOutlet weak var dispositionTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var bodyTempatureSubmittedLabel: UILabel!
    @IBOutlet weak var submittedDispositionLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyTempatureTextField.delegate = self
        dispositionTextField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        bodyTempatureTextField.resignFirstResponder()
        dispositionTextField.resignFirstResponder()
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitButtonTapped(sender: UIButton) {
        bodyTempatureSubmittedLabel.text = bodyTempatureTextField.text
        submittedDispositionLabel.text = dispositionTextField.text
        
        // reset text fields
        bodyTempatureTextField.text = ""
        dispositionTextField.text = ""
    }
    

}

