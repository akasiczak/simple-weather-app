//
//  WeatherViewModel.swift
//  simple-weather-app
//
//  Created by Adrian Kasiczak on 08/07/2019.
//  Copyright © 2019 Adrian Kasiczak. All rights reserved.
//

import UIKit
import DarkSkyKit

class WeatherViewModel: NSObject {
    
    func getNumberOfElementsWeatherForecast(for cityId: String) -> Int {
        return 0
    }
    
    func getWeatherForecastTemperature(for cityId: String) -> Array<String> {
        var array = Array<String>()
        return array
    }
    
    func getInfoCurrentWeather(with latitude: Double, andLongitude: Double) -> String {
        darkSkyConfig.current(latitude: latitude, longitude: andLongitude) { (result) in
            switch result {
            case .success(let forecast):
                if let current = forecast.currently {
                    let cityName = current.temperature
                }
            case .failure(let err):
                print("Error")
            }
        }
        
        return cityname
    }
    
}
