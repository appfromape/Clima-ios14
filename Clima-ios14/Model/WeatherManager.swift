//
//  WeatherManager.swift
//  Clima-ios14
//
//  Created by 程式猿 on 2021/2/28.
//

import Foundation
import CoreLocation

protocol WeatherManergerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManerger, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManerger {
    
    let appid = "put your openweathermap's appid here"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid="
    
    var delegate: WeatherManergerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlStr = "\(weatherURL)\(appid)&q=\(cityName)&units=metric"
        performRequest(with: urlStr)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlStr = "\(weatherURL)\(appid)&units=metric&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlStr)
    }
    
    func performRequest(with urlStr: String) {
        if let url = URL(string: urlStr) {
            let session = URLSession(configuration: .default)
            //            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
//                    print(error!)
                    return
                }
                
                if let safeDate = data {
//                    let dataString = String(data: safeDate, encoding: .utf8)
//                    print(dataString!)
                    if let weather = parseJSON(safeDate) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temp: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    //    func handle(data: Data?, response: URLResponse?, error: Error?) {
    //        if error != nil {
    //            print(error!)
    //            return
    //        }
    //
    //        if let safeDate = data {
    //            let dataString = String(data: safeDate, encoding: .utf8)
    //            print(dataString!)
    //        }
    //    }
    
}
