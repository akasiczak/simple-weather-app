//
//  WeatherViewController.swift
//  simple-weather-app
//
//  Created by Adrian Kasiczak on 09/07/2019.
//  Copyright © 2019 Adrian Kasiczak. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var lat = 0.0
    var long = 0.0
    
    let cellId = "cellId"
    
    let cityName: UILabel = {
        let label = UILabel()
        label.text = "City name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let weatherCondition: UILabel = {
        let label = UILabel()
        label.text = "Weather condition"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Temperature Label"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let weatherIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let forecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 120, height: 165)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        forecastCollectionView.dataSource = self
        forecastCollectionView.delegate = self
        forecastCollectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupLayout()
        
        view.backgroundColor = .lightGray
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func setupLayout() {
        view.addSubview(cityName)
        view.addSubview(weatherCondition)
        view.addSubview(temperatureLabel)
        view.addSubview(weatherIcon)
        view.addSubview(forecastCollectionView)
        
        NSLayoutConstraint.activate([
            
            cityName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            weatherCondition.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherCondition.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 15),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: weatherCondition.bottomAnchor, constant: 30),
            
            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            
            forecastCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            forecastCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forecastCollectionView.heightAnchor.constraint(equalToConstant: 200),
            forecastCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
    }
    
    //MARK Location Manager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        lat = location.coordinate.latitude
        long = location.coordinate.longitude
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(openWeatherApi)&units=metric").responseJSON { (response) in
            if let responseString = response.result.value {
                let jsonResponse = JSON(responseString)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonMain = jsonResponse["main"]
                let jsonTemp = jsonMain["temp"].stringValue
                let jsonCity = jsonResponse["name"].stringValue
                let jsonWeatherCondition = jsonWeather["description"].stringValue
//                let jsonWeatehrIcon = jsonWeather["01d"]
                
                self.cityName.text = jsonCity
                self.temperatureLabel.text = jsonTemp + "°C"
                self.weatherCondition.text = jsonWeatherCondition
            }
        }
    }
}


extension WeatherViewController: UICollectionViewDelegateFlowLayout {
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ForecastCollectionViewCell
        cell.backgroundColor = .yellow
        return cell
    }
}