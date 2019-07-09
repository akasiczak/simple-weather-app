//
//  WeatherViewController.swift
//  simple-weather-app
//
//  Created by Adrian Kasiczak on 09/07/2019.
//  Copyright © 2019 Adrian Kasiczak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {
    
    var forecastArray = [ForecastWeather]()
    
    let viewModel = WeatherViewModel()
    
    let cellId = "cellId"
    
    let searchButton: UIButton = {
       let btn = UIButton()
        
        btn.addTarget(self, action: #selector(searchButtonClick), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "search"), for: .normal)
        btn.tintColor = .white
        
        return btn
    }()
    
    @objc func searchButtonClick() {
        dismiss(animated: true, completion: nil)
    }
    
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
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        forecastCollectionView.dataSource = self
        forecastCollectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupLayout()
        setupColors()
        setupFonts()
    }
    
    func updateWeatherForLocation(location: String) {
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?q=\(location)&appid=\(openWeatherApi)&units=metric").responseJSON { (response) in
            if let responseString = response.result.value {
                let jsonResponse = JSON(responseString)
                if jsonResponse["cod"] == "404" {
                    print("błąd")
                } else {
                    let jsonList = jsonResponse["list"].array![0]
                    
                    let jsonMainTemp = jsonList["main"]
                    let jsonTemp = jsonMainTemp["temp"]
                    
                    let jsonWeather = jsonList["weather"].array![0]
                    let jsonDesription = jsonWeather["description"].stringValue
                    let jsonIcon = jsonWeather["icon"].stringValue
                    
                    let jsonCity = jsonResponse["city"]
                    let jsonName = jsonCity["name"].stringValue
                    
                    self.cityName.text = jsonName
                    self.temperatureLabel.text = jsonTemp.stringValue + "°C"
                    self.weatherCondition.text = jsonDesription
                    self.weatherIcon.image = UIImage(named: jsonIcon)?.maskWithColor(color: .white)
                    
                    if jsonTemp < 10 {
                        self.temperatureLabel.textColor = UIColor.CustomColors.cambridgeBlue
                    } else if jsonTemp > 10 && jsonTemp < 20 {
                        self.temperatureLabel.textColor = UIColor.black
                    } else {
                        self.temperatureLabel.textColor = UIColor.red
                    }
                }
            }
        }
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?q=\(location)&appid=\(openWeatherApi)&units=metric").responseJSON { (response) in
            if let responseString = response.result.value {
                if let dictionary = responseString as? Dictionary<String, AnyObject> {
                    if let jsonList = dictionary["list"] as? [Dictionary<String, AnyObject>] {
                        for item in jsonList {
                            let forecast = ForecastWeather(weatherDictionary: item)
                            self.forecastArray.append(forecast)
                        }
                    }
                    self.forecastCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateWeatherForLocation(location: locationString)
    }
    
    func setupLayout() {
        view.addSubview(searchButton)
        view.addSubview(cityName)
        view.addSubview(weatherCondition)
        view.addSubview(temperatureLabel)
        view.addSubview(weatherIcon)
        view.addSubview(forecastCollectionView)
        
        NSLayoutConstraint.activate([
            
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchButton.topAnchor.constraint(equalTo: cityName.topAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 25),
            searchButton.heightAnchor.constraint(equalToConstant: 25),
            
            cityName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            
            weatherCondition.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherCondition.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 15),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: weatherCondition.bottomAnchor, constant: 30),
            
            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 35),
            weatherIcon.widthAnchor.constraint(equalToConstant: 100),
            weatherIcon.heightAnchor.constraint(equalToConstant: 100),
            
            forecastCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            forecastCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forecastCollectionView.heightAnchor.constraint(equalToConstant: 200),
            forecastCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
    }
    
    func setupColors() {
        view.backgroundColor = UIColor.CustomColors.pineApple
        self.cityName.textColor = UIColor.CustomColors.tuscanYellow
        self.weatherCondition.textColor = UIColor.CustomColors.tuscanYellow
        self.forecastCollectionView.backgroundColor = UIColor.CustomColors.tuscanYellow
    }
    
    func setupFonts() {
        self.cityName.font = UIFont.CustomFonts.cityNameFont
        self.weatherCondition.font = UIFont.CustomFonts.conditionFont
        self.temperatureLabel.font = UIFont.CustomFonts.temperatureFont
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ForecastCollectionViewCell
        
        cell.layer.cornerRadius = 10
        cell.configureCell(forecastData: forecastArray[indexPath.row])
        
        return cell
    }
}
