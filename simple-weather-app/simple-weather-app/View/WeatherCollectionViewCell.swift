//
//  WeatherCollectionViewCell.swift
//  simple-weather-app
//
//  Created by Adrian Kasiczak on 08/07/2019.
//  Copyright © 2019 Adrian Kasiczak. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        forecastCollectionView.dataSource = self
        forecastCollectionView.delegate = self
        forecastCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        contentView.addSubview(cityName)
        contentView.addSubview(weatherCondition)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(forecastCollectionView)
        
        NSLayoutConstraint.activate([
            
            cityName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityName.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            weatherCondition.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherCondition.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 15),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: weatherCondition.bottomAnchor, constant: 30),
            
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            
            forecastCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            forecastCollectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            forecastCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            forecastCollectionView.heightAnchor.constraint(equalToConstant: 200),
            forecastCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        cell.backgroundColor = .yellow
        
        return cell
    }
}
