 //
//  NetworkUtils.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 13/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import UIKit
import Alamofire
 
class NetworkUtils {

/* Debido a que no se cuenta con un servidor, se ha desarrollado una serie de métodos falsos tanto para las llamadas Get como Post */

    
    /* ------------------------------------------ POST METHODS --------------------------------------------*/
    
    //Fake Login Request
    static func makeLoginRequestFake(email: String , password: String, completion: @escaping (Int?) -> Void) {
        //End Point URL
        let url=URL(string: "http://10.0.2.2:8000/user/create")
        
        print(email)
        print(password)
        
        //Parameters
        let paramData = ["email": email, "password": password]
        
        //Alamofire post request with parameters (No server connection)
        Alamofire.request(url!, method: .post, parameters: paramData, encoding: JSONEncoding.default, headers: nil).response {
            response in
            
            //Check if the return code is success
            //It will return always failure because it is not connected to an existing endpoint
            if (response.response?.statusCode == 200) {
                completion(nil)
            } else {
                //Check if the email and password are the ones from our fake user
                if (paramData["email"] == MockData.email && paramData["password"] == MockData.password){
                    completion(MockData.id)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    //Fake Recover Request
    static func makeRecoverRequestFake(email: String, completion: @escaping (Bool?) -> Void) {
        let url=URL(string: "http://10.0.2.2:8000/user/recover")
        
        print(email)
    
        //Parameters
        let paramData = ["email": email]
        
        //Alamofire post request with parameters (No server connection)
        Alamofire.request(url!, method: .post, parameters: paramData, encoding: JSONEncoding.default, headers: nil).response {
            response in
            
            //Check if the return code is success
            //It will return always failure because it is not connected to an existing endpoint
            if (response.response?.statusCode == 200) {
                completion(false)
            } else {
                //Check if the email and password are the ones from our fake user
                if (paramData["email"] == MockData.email){
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    //Fake register request
    static func makeRegisterRequestFake(email:String, password: String, completion: @escaping (Int?) -> Void) {
        let url=URL(string: "http://10.0.2.2:8000/user/register")
        
        //Parameters
        let paramData = ["email": email, "password": password]
        
        //Alamofire post request with parameters (No server connection)
        Alamofire.request(url!, method: .post, parameters: paramData, encoding: JSONEncoding.default, headers: nil).response {
            response in
            
            //Check if the return code is success
            //It will return always failure because it is not connected to an existing endpoint
            if (response.response?.statusCode == 200) {
                completion(nil)
            } else {
                //Check if the email and password are the ones from our fake user
                if (paramData["email"] == email && paramData["password"] == password){
                    completion(MockData.id)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    //Fake user data request
    static func getUserData(completion: @escaping (String?) -> Void) {
        //Initiallization
        //We use the MockedData user id as the id of an actually logged user
        let id = MockData.id
        //Endpoint
        let urlString = "http://10.0.2.2:8000/user/\(id)"
        let url = URL(string: urlString)
        
        //Alamofire get request with parameters through the URL
        Alamofire.request(url!).response {
            response in
            
            //Check if the return code is success
            //It will return always failure because it is not connected to an existing endpoint
            if (response.response?.statusCode == 200) {
                completion(nil)
            } else {
                completion(MockData.email)
            }
        }
    }
    
    //Fake request of user apps usage
    static func getUserGraphs(completion: @escaping ([String : Double]?) -> Void) {
        //Initiallization
        //We use the MockedData user id as the id of an actually logged user
        let id = MockData.id
        //Endpoint
        let urlString = "http://10.0.2.2:8000/user/\(id)/graphs"
        let url = URL(string: urlString)
        
        //Alamofire get request with parameters through the URL
        Alamofire.request(url!).response {
            response in
            
            //Check if the return code is success
            //It will return always failure because it is not connected to an existing endpoint
            if (response.response?.statusCode == 200) {
                completion(nil)
            } else {
                completion(MockData.graphs)
            }
        }
    }
    
    //Function that gets the list of apps installed by the user, and a total usage number of hours of each all
    static func getAppsFake(completion: @escaping ([String]?) -> Void) {
        //Initiallization
        //We use the MockedData user id as the id of an actually logged user
        let id = MockData.id
        //Endpoint
        let urlString = "http://10.0.2.2:8000/user/\(id)/apps"
        let url = URL(string: urlString)
        
        //Alamofire get request with parameters through the URL
        Alamofire.request(url!).response {
            response in
            
            //Check if the return code is success
            //It will return always failure because it is not connected to an existing endpoint
            if (response.response?.statusCode == 200) {
                completion(nil)
            } else {
                completion(MockData.apps)
            }
        }
    }
    
    //
    static func getAppsLocationFake(completion: @escaping ([App]?) -> Void) {
        //Initiallization
        //We use the MockedData user id as the id of an actually logged user
        let id = MockData.id
        //Fake Data to populate the view
        let csvData = DataHelpers.parseCsvData()
        print(csvData)
        //Endpoint
        let urlString = "http://10.0.2.2:8000/user/\(id)/mapvalues"
        let url = URL(string: urlString)
        
        //Alamofire get request with parameters through the URL
        Alamofire.request(url!).response {
            response in
            
            //Check if the return code is success
            //It will return always failure because it is not connected to an existing endpoint
            if (response.response?.statusCode == 200) {
                completion(nil)
            } else {
                if let apps = csvData as? [App]{
                    completion(apps)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    //Function that sends to the database a new rule for a certain app
//    static func setAppRuleFake(email:String) -> Bool {
//        let url=URL(string: "http://10.0.2.2:8000/user/"+ id +"/app/"+ app_id "/rule/")
//        var result: Bool = false
//
//        //POST function from Alamofire
//        Alamofire.request(url!, method: .post, parameters: ["email": email], encoding: JSONEncoding.default, headers: nil).response {
//            response in
//
//            //Check if the code is success or failure, in this case we use the failure because we doesn't have a server
//            if (response.response?.statusCode == 200) {
//                result = false
//            } else {
//                result = true
//            }
//
//        }
//        print(result)
//
//        return result
//    }
    
    /* ------------- GET METHODS -------------- */
    
    //Function that request to the server all longitude and latitude of the user apps
//    static func getAppsLocationFake() -> Bool {
//        let url=URL(string: "http://10.0.2.2:8000/user/" + id + "/apps/location")
//        var result: Bool = false
//        let user_id: Int = 6
// 
//        //POST function from Alamofire
//        Alamofire.request(url!, method: .get, parameters: ["id": user_id], encoding: JSONEncoding.default, headers: nil).response {
//            response in
//            
//            //Check if the code is success or failure, in this case we use the failure because we doesn't have a server
//            if (response.response?.statusCode == 200) {
//                result = false
//            } else {
//                result = true
//            }
//            
//        }
//        print(result)
//        
//        //Devolver las apps
//        
//        
//        return result
//    }
    
    
    
    
    
    
    
    
    //Standard Get Call - Receives an URL
    static func makeGetCall(url: String) {
        // Set up the URL request
        let endpoint: String = url
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            // check for any errors
            guard error == nil else {
                print("error calling GET on /animals")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let resp = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                
                // let's just print it to prove we can access it
                print("The todo is: " + resp.description)
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
}
