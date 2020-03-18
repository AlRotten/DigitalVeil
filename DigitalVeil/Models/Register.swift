//
//  Register.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 13/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

struct RegisterResponse: Codable {
    var code: Int?
    var msg, errorMsg: String?
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        case code
        case errorMsg = "error_msg"
        case msg
        case user
    }
    
}

