//
//  WeatherModel.swift
//  Clima
//
//  Created by Hamed Hashemi on 6/21/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let conditionId: Int
    let temperature: Double
    
    // computed property
    var temperatureString: String {
        String(format: "%.1f", temperature)
    }
    
    // computed property
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sparkles"
        case 801...804:
            return "cloud.fill"
        default:
            return "Defualt, something went wrong."
        }
    }
}
