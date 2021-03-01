//
//  WeatherData.swift
//  Clima-ios14
//
//  Created by 程式猿 on 2021/2/28.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
