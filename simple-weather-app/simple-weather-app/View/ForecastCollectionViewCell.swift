//
//  ForecastCollectionViewCell.swift
//  simple-weather-app
//
//  Created by Adrian Kasiczak on 08/07/2019.
//  Copyright © 2019 Adrian Kasiczak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForecastCollectionViewCell: UICollectionViewCell {
    
    let timeLabel: UILabel = {
       let label = UILabel()
        
        label.text = "time"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let iconImageView: UIImageView = {
       let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let temperatureForTimeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "16C"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        setupLayout()
    }
    
    func setupLayout() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(temperatureForTimeLabel)
        
        NSLayoutConstraint.activate([
            
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: iconImageView.topAnchor, constant: 20),
            
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            temperatureForTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            temperatureForTimeLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(forecastData: ForecastWeather) {
        self.timeLabel.text = "\(forecastData.date)"
        self.temperatureForTimeLabel.text = "\(forecastData.temp)"
    }
}
