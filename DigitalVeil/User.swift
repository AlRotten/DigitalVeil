//
//  User.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 13/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int?
    var email, userName, location, password,picture: String?
    var adminUser, active: Int?
    var token: String?
    
    init(email:String,password:String,userName:String?) {
        
        self.email=email
        self.password=password
        self.userName=userName
        self.token = nil
        self.location=nil
        self.picture = nil
        self.id = nil
        
    }
    init(email:String,password:String) {
        
        self.email=email
        self.password=password
        self.userName=nil
        self.token = nil
        self.location=nil
        self.picture = nil
        self.id = nil
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id, email,password
        case userName = "user_name"
        case location, picture
        case adminUser = "admin_user"
        case active, token
    }
    
}
