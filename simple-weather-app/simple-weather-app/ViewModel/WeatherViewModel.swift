//
//  WeatherViewModel.swift
//  simple-weather-app
//
//  Created by Adrian Kasiczak on 09/07/2019.
//  Copyright © 2019 Adrian Kasiczak. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewModel: NSObject {
    
    func getColorForTemperature(temperature: Int) -> UIColor {
        if temperature < 10 {
            return .blue
        } else if temperature > 10 && temperature < 20 {
            return .black
        } else {
            return .red
        }
    }
}
