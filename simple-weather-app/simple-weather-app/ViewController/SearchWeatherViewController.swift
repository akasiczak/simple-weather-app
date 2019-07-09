//
//  SearchWeatherViewController.swift
//  simple-weather-app
//
//  Created by Adrian Kasiczak on 09/07/2019.
//  Copyright © 2019 Adrian Kasiczak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public var locationString = ""

class SearchWeatherViewController: UIViewController {

    let searchTextField: UITextField = {
       let field = UITextField()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter your city here"
        
        return field
    }()
    
    let getDataButton: UIButton = {
       let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(getDataAndDismiss), for: .touchUpInside)
        btn.setTitle("Search for city", for: .normal)
        btn.layer.cornerRadius = 10
        
        return btn
    }()
    
    @objc func getDataAndDismiss() {
        let formattedString = searchTextField.text?.replacingOccurrences(of: " ", with: "&")
        locationString = formattedString!
        let vc = WeatherViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupColors()
    }
    
    func setupLayout() {
        view.addSubview(searchTextField)
        view.addSubview(getDataButton)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchTextField.heightAnchor.constraint(equalToConstant: 200),
            
            getDataButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 30),
            getDataButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            getDataButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            getDataButton.heightAnchor.constraint(equalToConstant: 50),
            ])
    }
    
    func setupColors() {
        view.backgroundColor = UIColor.CustomColors.paleSpringBud
        getDataButton.backgroundColor = UIColor.CustomColors.pineApple
    }
}
