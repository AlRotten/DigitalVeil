//
//  MapModels.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 14/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import Foundation

struct App: Codable{
    
    var Date: String
    
    var App: String
    
    var Event: String
    
    var Latitude: Double
    
    var Longitude: Double
    
    init(Date: String, App: String, Event: String, Latitude: Double, Longitude: Double){
        
        self.Date = Date
        
        self.App = App
        
        self.Event = Event
        
        self.Latitude = Latitude
        
        self.Longitude = Longitude
        
    }
    
    enum CodingKeys: String, CodingKey {
        case Date
        
        case App
        
        case Event
        
        case Latitude
        
        case  Longitude
        
    }
    
}
