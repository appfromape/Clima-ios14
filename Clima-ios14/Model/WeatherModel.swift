//
//  WeatherModel.swift
//  Clima-ios14
//
//  Created by 程式猿 on 2021/2/28.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temp: Double
    
    var tempDicimal: String {
        return String(format: "%.1f", temp)
    }
    
    var conditionName: String {
        if conditionId < 233 {
            return "cloud.bolt.fill"
        } else if conditionId < 322 {
            return "cloud.drizzle"
        } else if conditionId < 532 {
            return "cloud.rain.fill"
        } else if conditionId < 623 {
            return "snow"
        } else if conditionId < 782 {
            return "aqi.medium"
        } else if conditionId == 800 {
            return "sun.min"
        } else {
            return "smoke.fill"
        }
    }
    
//    func getConditionName(weatherId: Int) -> String {
//        if weatherId < 233 {
//            return "cloud.bolt.fill"
//        } else if weatherId < 322 {
//            return "cloud.drizzle"
//        } else if weatherId < 532 {
//            return "cloud.rain.fill"
//        } else if weatherId < 623 {
//            return "snow"
//        } else if weatherId < 782 {
//            return "aqi.medium"
//        } else if weatherId == 800 {
//            return "sun.min"
//        } else {
//            return "smoke.fill"
//        }
//    }
}
