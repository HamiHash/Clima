import Foundation

// Assigned a protocol-delegate to be able to reuse this on different classe's
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=eac5dad596a12a1c02505697ae6b4f95&units=metric"
    
    func fetchWeather(city: String?, lat: Double?, lon: Double?) {
        var urlString: String
        
        if (lat == nil) {
            urlString = "\(weatherURL)&q=\(city ?? "")"
        } else {
            urlString = "\(weatherURL)&lat=\(lat!)&lon=\(lon!)"
        }
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {  // the "with" makes it easier to read. it's like "_"
        // create url
        let url = URL(string: urlString)!
        
        // create session
        let session = URLSession(configuration: .default)
        
        // give session a task
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.didFailWithError(error!)
                return
            }
            
            if let safeData = data {
                // we used "if let" here becouse parseJSON's returned value is optional
                if let weatherParsed = self.parseJSON(safeData) {
                    self.delegate?.didUpdateWeather(self, weather: weatherParsed)
                }
            }
        }
        
        // start task
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            
            let weather = WeatherModel(cityName: decodedData.name, conditionId: id, temperature: decodedData.main.temp)
            
            return weather
        } catch {
            self.delegate?.didFailWithError(error)
            return nil
        }
    }
}

