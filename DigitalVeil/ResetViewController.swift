//
//  ResetViewController.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 14/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

class ResetViewController: UIViewController {

    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextFieldWithIcon!
    
    @IBAction func resetButton(_ sender: Any) {
        let userEmail = userEmailTF.text;
        
        if(userEmail!.isEmpty) {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage:"All fields are required", alertType: 0), animated: true, completion: nil)
            return;
            
        } else {
            if(DataHelpers.isValidEmail(userEmail!)){
                resetPassword(email: userEmail!)
            }
        }
    }
    
    override func viewDidLoad() {
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        super.viewDidLoad()
    }
    
    func resetPassword(email: String) {
        print(email)
    }
    
    // This will notify us when something has changed on the textfield
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextFieldWithIcon {
                var errorMessage=""
                switch textfield {
                    
                case userEmailTF:
                    if(!DataHelpers.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }

                default:
                    errorMessage = ""
                }
                
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
    
}
