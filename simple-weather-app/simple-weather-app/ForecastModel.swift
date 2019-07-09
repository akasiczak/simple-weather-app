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
    var icon: String!
    
    
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
        
        if let weather = weatherDictionary["weather"] as? [Dictionary<String, AnyObject>] {
            
            for icon in weather {
                if let icon = icon["icon"] as? String {
                    self.icon = icon
                }
            }
//            if let icon = weather["icon"] as? String {
//                self.icon = icon
//            }
        }
    }
}

extension Date {
    func hour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, ha"
        return dateFormatter.string(from: self)
    }
}
