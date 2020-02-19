//
//  LoginViewController.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 13/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import UIKit
import Alamofire
import SkyFloatingLabelTextField

class LoginPageViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextFieldWithIcon!
    
    
    
    //Displays an alert with a message depending on the string passed through parameters
    @IBAction func loginButton(_ sender: Any) {
        let userEmail = userEmailTF.text;
        let userPassword = userPasswordTF.text;
        
        if (userEmail!.isEmpty || userPassword!.isEmpty) {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage:"All fields are required", alertType: 0), animated: true, completion: nil)
            return;
            
        } else {
            
            if (DataHelpers.isValidEmail(userEmail!) && DataHelpers.isValidPassword(userPassword!)) {
                loginUser(email: userEmail!, password: userPassword!) {
                    (isWorking) in
                    
                    if (isWorking) {
                        //self.present(DataHelpers.displayAlert(userMessage:"successful login!", alertType: 1), animated: true, completion: nil)
                        self.segueLogin()
                    }
                    
                }
                
            }
            
            
        }
        
        
    }
    
    override func viewDidLoad() {
        //Targets
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // This will notify us when something has changed on the textfield
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextFieldWithIcon {
                var errorMessage=""
                switch textfield {
                    
                    //Email validator call
                case userEmailTF:
                    if(!DataHelpers.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }
                    //Password validator call
                case userPasswordTF:
                    if(!DataHelpers.isValidPassword(text)) {
                        errorMessage = "Must contains 8 characters and 1 number"
                    }
                default:
                    errorMessage = ""
                }
                
                //Set the message
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
    
    //User login request
    func loginUser(email:String,password:String, completion: @escaping (Bool) -> ()){
        
        //Login call - UTILS6
        
        //let url:String = "http://10.0.2.2:8000/animals"
        //NetworkUtils.makeGetCall(url:url)
        let isWorking = true
        completion(isWorking)
        
    }
    
    //Segue that connects both Storyboards of the Ap
    //It is called only from the LoginView whenever the Login of a valid user is made.
    func segueLogin()  {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let targetViewController = storyboard.instantiateInitialViewController() {
            self.navigationController?.pushViewController((targetViewController), animated: true)
        }
    }

}
