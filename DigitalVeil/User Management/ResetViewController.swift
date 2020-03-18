//
//  ResetViewController.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 14/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import SkyFloatingLabelTextField

class ResetViewController: UIViewController {
    //Initiallization
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextFieldWithIcon!
    
    //Spinner initiallization
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //Reset button action that triggers the whole logic of the reset password request, validating all field values before making the request and managing the result of the request
    @IBAction func resetButton(_ sender: Any) {
        //Initialization
        let userEmail = userEmailTF.text;
        
        if(userEmail!.isEmpty) {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage:"All fields are required", alertType: 0), animated: true, completion: nil)
            return;
            
        } else {
            
            //Validation of the field values
            if(DataHelpers.isValidEmail(userEmail!)){
                //Start loading animation of the spinner
                DataHelpers.toggleLoadingSpinner(animate: true, activityIndicator: activityIndicator)
                
                //Make the password reset request
                resetPassword(email: userEmail!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Target of the user email TextField
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //Spinner config
        DataHelpers.spinnerConfig(activityIndicator: activityIndicator, UIView: self)
        
        //Add spinner to te view
        self.view.addSubview(activityIndicator)
    }
    
    //Function designed to manage the returned value of the recover request
    func resetPassword(email: String) {
        //NetworUtils Recover request call
        NetworkUtils.makeRecoverRequestFake(email: email, completion: {
            response in
            
            if (response!) {
                self.present(DataHelpers.displayAlert(userMessage: "Email sended!", alertType: 1), animated: true, completion: nil)
            } else {
                self.present(DataHelpers.displayAlert(userMessage: "DigitalVeil didn't recognize this email", alertType: 0), animated: true, completion: nil)
            }
            
            //Stop spinner animation
            DataHelpers.toggleLoadingSpinner(animate: false, activityIndicator: self.activityIndicator)
        })
    }
    
    // This will notify us when something has changed on the textfield
    @objc func textFieldDidChange(_ textfield: UITextField) {
        //Validate textFields on every change of their values
         DataHelpers.textFieldOnChangeValidation(textField: textfield, userEmail: userEmailTF, userPassword: nil, userConfirmPassword: nil)
    }
    
}
