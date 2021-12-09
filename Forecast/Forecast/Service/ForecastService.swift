//
//  ForecastService.swift
//  Forecast
//
//  Created by Damien Chailloleau on 06/12/2021.
//

import Foundation

protocol ForecastService {
    func fetchWeather(_ query: String) async throws -> Forecast
    func fetchWeekWeather(_ lat: Double, _ lon: Double) async throws -> [Daily]
}

final class ForecastServiceImpl: ForecastService {
    
    func fetchWeather(_ query: String) async throws -> Forecast {
        let urlSession = URLSession.shared
        let url = URL(string: APIConstant.baseURL.appending("&q=\(query)"))
        let (data, _) = try await urlSession.data(from: url!)
        return try JSONDecoder().decode(Forecast.self, from: data)
    }
    
    func fetchWeekWeather(_ lat: Double, _ lon: Double) async throws -> [Daily] {
        let urlSession = URLSession.shared
        let url = URL(string: APIConstant.baseWeekURL.appending("&lat=\(lat)&lon=\(lon)"))
        let (data, _) = try await urlSession.data(from: url!)
        let array = try JSONDecoder().decode(ForecastWeekModel.self, from: data)
        return array.daily
    }
    
}
