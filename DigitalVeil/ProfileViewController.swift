//
//  ProfileViewController.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 17/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import UIKit
import UserNotifications

class ProfileViewController: UIViewController {
    //Initiallization
    @IBOutlet weak var userEmailLabel: UILabel!
    
    //Spinner initiallization
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // Log Out Function
    // Segue to Login View
    @IBAction func logOut(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "Nav")
        self.present(initialViewController, animated: true, completion: nil)
    }
    
    // Reset Password Segue - In order to get a new Password
    @IBAction func segueReset(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let navigationController = UINavigationController(nibName: "Nav", bundle: nil)
        let viewController = UIViewController(nibName: "ResetPassword", bundle: nil)
        navigationController.show(viewController, sender: self)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ResetPassword")
        self.present(initialViewController, animated: true, completion: nil)
    }
    
    // Función donde indepedientemente del index que tenga el selector, te envía una alerta de permisos de notificaciones.
    @IBAction func notificationsSelector(_ sender: Any) {
        let content = UNMutableNotificationContent()
        
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound]){
            (autorize,error) in
            if autorize {
                print("Permiso concedido")
            } else {
                print("Permiso denegado")
            }
        }
        content.body = "Notificaciones desactivadas"
    }
    
    // Function called before the view is loaded
    override func viewWillAppear(_ animated: Bool) {
        //Get rid of the Navigation Controller from the previous storyboard
         navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        //Spinner config
        DataHelpers.spinnerConfig(activityIndicator: activityIndicator, UIView: self)
        
        //Add spinner to the view
        self.view.addSubview(activityIndicator)
        
        //Get one user's relative data and place values on the view
        getUserData()
    }
    

    func getUserData() {
        //Start loading animation of the spinner
        DataHelpers.toggleLoadingSpinner(animate: true, activityIndicator: activityIndicator)
        
        //Make the data request
        NetworkUtils.getUserData(completion: {
            response in
            
            if let email = response {
                self.userEmailLabel.text = email
            } else {
                //Alert message
                self.present(DataHelpers.displayAlert(userMessage: "Something went wrong! Try again later", alertType: 0), animated: true, completion: nil)
                
                self.userEmailLabel.text = ""
            }
            
             DataHelpers.toggleLoadingSpinner(animate: false, activityIndicator: self.activityIndicator)
        })
    }
}
 

