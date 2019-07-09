//
//  DateExtension.swift
//  simple-weather-app
//
//  Created by Adrian Kasiczak on 09/07/2019.
//  Copyright © 2019 Adrian Kasiczak. All rights reserved.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha, MMM d"
        return dateFormatter.string(from: self)
    }
}
