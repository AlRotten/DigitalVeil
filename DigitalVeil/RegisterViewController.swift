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
    
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userConfirmPassword: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userConfirmPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // This will notify us when something has changed on the textfield
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                var errorMessage=""
                switch textfield {
                    case userEmailTF:
                        if(!DataHelpers.isValidEmail(text)) {
                            errorMessage = "Invalid email"
                        }
                    case userPasswordTF:
                        if(!DataHelpers.isValidPassword(text)) {
                            errorMessage = "Must contains 8 characters and 1 number"
                        }
                    case userConfirmPassword:
                        if(!DataHelpers.isValidRepeatedPassword(text, userPasswordTF.text ?? "" )) {
                            errorMessage = "Passwords doesn't match"
                        }
                    default:
                        break
                }
                
                floatingLabelTextField.errorMessage = errorMessage
            }
        }
    }
    
    //Sign up button event
    @IBAction func signUpButton(_ sender: Any) {
        
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
            if ( DataHelpers.isValidPassword(userPassword!) && DataHelpers.isValidEmail(userEmail!)){
                
                //Validation of passwords
                createUser(email: userEmail!,password: userPassword!)
                
            } else {
                
                self.present(DataHelpers.displayAlert(userMessage: "Woof! you need to fix that first", alertType: 0), animated: true, completion: nil)
            }
        }
        
    }
    func createUser (email:String, password:String)  {
//        let url = URL(string:"http://0.0.0.0:8888/petit-api/public/api/user")
//        let user=User( email: email, password: password, userName: userName)
//
//        AF.request(url!,
//                   method: .post,
//                   parameters:user,
//                   encoder: JSONParameterEncoder.default
//
//            ).response { response in
//                if(response.error==nil){
//                    do{
//                        let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
//                        if(responseData.code==200) {
//                            self.segueLogin()
//                            self.present(DataHelpers.displayAlert(userMessage:"Registered!", alertType: 1), animated: true, completion: nil)
//                        }else{
//                            self.present(DataHelpers.displayAlert(userMessage:responseData.errorMsg ?? "", alertType: 0), animated: true, completion: nil)
//                        }
//
//                    }catch{
//                        print(error)
//
//                    }
//                }else{
//                    self.present(DataHelpers.displayAlert(userMessage: "Network error", alertType: 0), animated: true, completion: nil)
//                }
//
//        }
//
//    }
//        performSegue(withIdentifier: "registerSegue", sender: nil)
        
//  TODO      self.present(DataHelpers.displayAlert(userMessage:"Registered!", alertType: 1), animated: true, completion: nil)
//
        
        
        
        //Segue that connects both Storyboards of the Ap
        //It is called only from the LoginView whenever the Login of a valid user is made.
        func segueLogin()  {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let targetViewController = storyboard.instantiateInitialViewController() {
                self.navigationController?.pushViewController((targetViewController), animated: true)
            }
        }
        
        //REGISTER call - UTILS6
        segueLogin()
    }
    
    
    
}
