//
//  Services.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 14/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import Foundation
import Alamofire

class Services: UIViewController {

    func loginPost(){
        
        let user = "alrodesis@gmail.com"
        let password = "1234567e"
        
        let parameters: [String:Any] = [ "email" : user , "password" : password ]
        let urlString = "http://10.0.2.2:8000/user/login"
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            //Alamofire.request(urlString)
            
            //V.1
            //let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
            //try JSONSerialization.data(withJSONObject: response.data!, options: [])
            
            .response { response in
                print(response);
                if(response.error == nil){
                    var isWorking = false
                    do{
                        let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                        if(responseData.code==200) {
                            isWorking = true
                            completion(isWorking)
                        }else{
                            self.present(DataHelpers.displayAlert(userMessage:responseData.errorMsg ?? "", alertType: 0), animated: true, completion: nil)
                            completion(isWorking)
                        }
                    }catch{
                        print(error)
                    }
                }else{
                    self.present(DataHelpers.displayAlert(userMessage: "Network error", alertType: 0), animated: true, completion: nil)
                }
                
        }
        
        
        
        
    }


}
