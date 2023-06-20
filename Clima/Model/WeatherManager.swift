//
//  WeatherManager.swift
//  Clima
//
//  Created by Hamed Hashemi on 6/19/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=eac5dad596a12a1c02505697ae6b4f95&units=metric"
    
    func fetchWeather(city: String) {
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // create url
        if let url = URL(string: urlString) {
            // create session
            let session = URLSession(configuration: .default)
            // give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            // start task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].id)
        } catch {
            print(error)
        }
    }
    
    func getConditionName(id: Int) {
        switch id {
            case 
        }
    }
}
