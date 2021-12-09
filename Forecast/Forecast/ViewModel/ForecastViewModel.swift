//
//  ForecastViewModel.swift
//  Forecast
//
//  Created by Damien Chailloleau on 06/12/2021.
//

import Foundation

protocol ForecastViewModel: ObservableObject {
    func fetchWeather(_ query: String) async
    func fetchWeekWeather(_ lat: Double, _ lon: Double) async
}

@MainActor
final class ForecastViewModelImpl: ForecastViewModel {
    
    @Published private(set) var weather: Forecast = Forecast.dummyWeather
    @Published private(set) var weatherWeek: [Daily] = []
    
    private let service: ForecastService
    
    init(service: ForecastService) {
        self.service = service
    }
    
    func fetchWeather(_ query: String) async {
        do {
            self.weather = try await service.fetchWeather(query)
        } catch DecodingError.keyNotFound(let key, let context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
    }
    
    func fetchWeekWeather(_ lat: Double, _ lon: Double) async {
        do {
            self.weatherWeek = try await service.fetchWeekWeather(lat, lon)
        } catch DecodingError.keyNotFound(let key, let context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
    }
    
}
