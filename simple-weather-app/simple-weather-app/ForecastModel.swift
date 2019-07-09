//
//  ForecastModel.swift
//  simple-weather-app
//
//  Created by Adrian Kasiczak on 09/07/2019.
//  Copyright © 2019 Adrian Kasiczak. All rights reserved.
//

import Foundation

class ForecastWeather {
    var date: String!
    var temp: Double!
    
    init(weatherDictionary: Dictionary<String, AnyObject>) {
        if let main = weatherDictionary["main"] as? Dictionary<String, AnyObject> {
            if let temp = main["temp"] as? Double {
                self.temp = temp.rounded()
            }
        }
        
        if let date = weatherDictionary["dt"] {
            
            let rawDate = Date(timeIntervalSince1970: date as! TimeInterval)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            self.date = "\(rawDate.hour())"
        }
    }
}

extension Date {
    func hour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        return dateFormatter.string(from: self)
    }
}
