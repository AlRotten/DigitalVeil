//
//  RegisterViewController.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 17/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import UIKit
import Foundation
import SkyFloatingLabelTextField
import Alamofire

class RegisterPageViewController: UIViewController, UITextFieldDelegate {
    //Initiallization
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var userConfirmPassword: SkyFloatingLabelTextField!
    
    //Spinner initiallization
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Targets of the userEmail, userPassword and userConfirmPassword TextFields
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userConfirmPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        //Spinner config
        DataHelpers.spinnerConfig(activityIndicator: activityIndicator, UIView: self)
        
        //Add spinner to the view
        self.view.addSubview(activityIndicator)
    }
    
    //Sign up button event
    @IBAction func signUpButton(_ sender: Any) {
        //Initiallization
        let userEmail = userEmailTF.text
        let userPassword = userPasswordTF.text
        let repeatedPassword = userConfirmPassword.text
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || repeatedPassword!.isEmpty)
        {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage: "All fields are required", alertType: 0), animated: true, completion: nil)
            return;
            
        } else {
            
            //Validation of email and password
            if ( DataHelpers.isValidPassword(userPassword!) && DataHelpers.isValidEmail(userEmail!) && DataHelpers.isValidRepeatedPassword(repeatedPassword!, userPassword!)){
                //Starts loading animation of the spinner
                DataHelpers.toggleLoadingSpinner(animate: true, activityIndicator: activityIndicator)
                
                //Validation of passwords
                createUser(email: userEmail!,password: userPassword!)
            } else {
                
                //Alert message
                self.present(DataHelpers.displayAlert(userMessage: "You need to fix that errors first", alertType: 0), animated: true, completion: nil)
            }
        }
    }
    
    //User register request.
    //This function will always return true because taht value will be used later on another function to stop the loading animation
    func createUser (email:String, password:String)  {
        //NetworkUtils Register request call
        NetworkUtils.makeRegisterRequestFake(email: email, password: password, completion: {
            response in
            
            if let id = response {
                self.segueLogin()
                //response of the request will be the user id in case of success
                print(id)
                
            } else {
                //Alert message
                self.present(DataHelpers.displayAlert(userMessage: "Wrong email or password!", alertType: 0), animated: true, completion: nil)
                //Reset of the password field
                self.userPasswordTF.text = ""
            }
            
            //Stop spinner animation
            DataHelpers.toggleLoadingSpinner(animate: false, activityIndicator: self.activityIndicator)
        })
    }
    
    //Segue that connects both Storyboards of the App
    //It is called only from the LoginView whenever the Login of a valid user is made.
    func segueLogin()  {
        //Reference of the target storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let targetViewController = storyboard.instantiateInitialViewController() {
            self.navigationController?.pushViewController((targetViewController), animated: true)
        }
    }
    
    // This will notify us when something has changed on the textfield
    @objc func textFieldDidChange(_ textfield: UITextField) {
        DataHelpers.textFieldOnChangeValidation(textField: textfield, userEmail: userEmailTF, userPassword: userPasswordTF, userConfirmPassword: userConfirmPassword)
    }
    
}
