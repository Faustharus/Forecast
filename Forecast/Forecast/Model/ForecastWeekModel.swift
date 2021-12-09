//
//  ForecastWeekModel.swift
//  Forecast
//
//  Created by Damien Chailloleau on 07/12/2021.
//

import Foundation
import CoreLocation

struct ForecastWeekModel: Codable, Hashable {
    let daily: [Daily]
}

struct Daily: Codable, Hashable {
    let dt: Double
    let temp: Temp
    let pressure: Double
    let humidity: Int
    let weather: [WeatherData]
}

struct Temp: Codable, Hashable {
    let day: Double
}

struct WeatherData: Codable, Hashable {
    let id: Int
    let description: String
}

extension Daily {
    
    static let dummyWeekWeather: [Daily] = [
        Daily(dt: 1638790015759, temp: Temp.init(day: 18.2), pressure: 1015.20, humidity: 55, weather: [WeatherData.init(id: 200, description: "cloud")]),
        Daily(dt: 1638790102159, temp: Temp.init(day: 15.2), pressure: 1010.07, humidity: 85, weather: [WeatherData.init(id: 200, description: "cloud")]),
        Daily(dt: 1638790188559, temp: Temp.init(day: 16.1), pressure: 1011.97, humidity: 36, weather: [WeatherData.init(id: 200, description: "cloud")]),
        Daily(dt: 1638790274959, temp: Temp.init(day: 13.7), pressure: 1016.82, humidity: 41, weather: [WeatherData.init(id: 200, description: "cloud")]),
        Daily(dt: 1638790361359, temp: Temp.init(day: 13.1), pressure: 1014.00, humidity: 39, weather: [WeatherData.init(id: 200, description: "cloud")]),
        Daily(dt: 1638790447759, temp: Temp.init(day: 18.7), pressure: 1017.13, humidity: 23, weather: [WeatherData.init(id: 200, description: "cloud")]),
        Daily(dt: 1638790534159, temp: Temp.init(day: 18.0), pressure: 1016.89, humidity: 20, weather: [WeatherData.init(id: 200, description: "cloud")])
    ]
    
}
