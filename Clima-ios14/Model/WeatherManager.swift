//
//  WeatherManager.swift
//  Clima-ios14
//
//  Created by 程式猿 on 2021/2/28.
//

import Foundation

struct WeatherManerger {
    
    let appid = "put your openweathermap's appid here"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid="
    
    func fetchWeather(cityName: String) {
        let urlStr = "\(weatherURL)\(appid)&q=\(cityName)"
        performRequest(urlStr: urlStr)
    }
    
    func performRequest(urlStr: String) {
        if let url = URL(string: urlStr) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeDate = data {
            let dataString = String(data: safeDate, encoding: .utf8)
            print(dataString!)
        }
    }
    
}
