//
//  User.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 13/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import Foundation

struct User: Codable {
    var email, password: String?
    
    init(email:String,password:String) {
        self.email=email
        self.password=password
    }

    enum CodingKeys: String, CodingKey {
        case email,password
    }
    
}
