//
//  WeatherCollectionViewController.swift
//  simple-weather-app
//
//  Created by Adrian Kasiczak on 08/07/2019.
//  Copyright © 2019 Adrian Kasiczak. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class WeatherCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WeatherCollectionViewCell
        
    
        cell.backgroundColor = .red
    
        return cell
    }
}
