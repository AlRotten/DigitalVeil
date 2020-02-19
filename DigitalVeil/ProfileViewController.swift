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
    
    // Log Out Function
    // Segue to Login View
    @IBAction func logOut(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "Nav")
        self.present(initialViewController, animated: true, completion: nil)
    }
    
    // Reset Password Segue - In orther to get a new Password
    @IBAction func segueReset(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
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

}
 

