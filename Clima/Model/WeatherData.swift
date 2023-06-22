//
//  WeatherData.swift
//  Clima
//
//  Created by Hamed Hashemi on 6/20/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Weather: Decodable {
    let description: String
    let id: Int
}

struct Main: Decodable {
    let temp: Double
}
