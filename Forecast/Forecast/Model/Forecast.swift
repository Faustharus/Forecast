//
//  Forecast.swift
//  Forecast
//
//  Created by Damien Chailloleau on 06/12/2021.
//

import Foundation

struct Forecast: Codable, Hashable {
    let name: String
    let main: Main
    let wind: Wind
    let weather: [Weather]
}

struct Main: Codable, Hashable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Wind: Codable, Hashable {
    let speed: Double
    let deg: Int
}

struct Weather: Codable, Hashable {
    let id: Int
    let description: String
}

extension Forecast {
    
    static let dummyWeather: Forecast = Forecast.init(name: "London", main: Main.init(temp: 18.6, tempMin: 14.2, tempMax: 18.8, pressure: 1015, humidity: 55), wind: Wind.init(speed: 5.69, deg: 1), weather: [Weather.init(id: 200, description: "cloud")])
    
}
