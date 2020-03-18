//
//  LoginViewController.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 13/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import SkyFloatingLabelTextField

class LoginPageViewController: UIViewController, UITextFieldDelegate {
    //Initialization
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextFieldWithIcon!

    //Spinner initiallization
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //Login button action that triggers the whole logic of the login request, validating all field values before making the request and managing the result of the request
    @IBAction func loginButton(_ sender: Any) {
        let userEmail = userEmailTF.text;
        let userPassword = userPasswordTF.text;
        
        if (userEmail!.isEmpty || userPassword!.isEmpty) {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage:"All fields are required", alertType: 0), animated: true, completion: nil)
            return;
            
        } else {
            
            //Validation of the field values
            if (DataHelpers.isValidEmail(userEmail!) && DataHelpers.isValidPassword(userPassword!)) {
                //Start loading animation of the spinner
                DataHelpers.toggleLoadingSpinner(animate: true, activityIndicator: activityIndicator)
                
                //Make the login request
                loginUser(email: userEmail!, password: userPassword!)
            } else {
                
                //Alert message
                self.present(DataHelpers.displayAlert(userMessage: "You need to fix that errors first", alertType: 0), animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Targets of the userEmail and userPassword TextFields
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        //Spinner config
        DataHelpers.spinnerConfig(activityIndicator: activityIndicator, UIView: self)
        
        //Add spinner to the view
        self.view.addSubview(activityIndicator)
        
        //NavigationController config
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // This will notify us when something has changed on the textfield
    @objc func textFieldDidChange(_ textfield: UITextField) {
        //Validate textFields on every change of their values
        DataHelpers.textFieldOnChangeValidation(textField: textfield, userEmail: userEmailTF, userPassword: userPasswordTF, userConfirmPassword: nil)
    }
    
    //User login request.
    //This function will always return true because that value will be used later on another function to stop the loading animation
    func loginUser(email:String,password:String) {
        //NetworkUtils Login request call
        NetworkUtils.makeLoginRequestFake(email: email, password: password, completion: {
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

}
