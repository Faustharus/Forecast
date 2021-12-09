//
//  ForecastView.swift
//  Forecast
//
//  Created by Damien Chailloleau on 06/12/2021.
//

import SwiftUI

struct ForecastView: View {
    
    let currentWeather: Forecast
    
    var body: some View {
        VStack {
            Text(currentWeather.name)
                .font(.title.weight(.thin))
                .foregroundColor(.white)
            
            Image(systemName: conditionName)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text(currentWeather.weather[0].description)
                .font(.headline.lowercaseSmallCaps())
                .foregroundColor(.white)
                .padding()
            
            HStack {
                Text("\(currentWeather.main.temp, specifier: "%.2f")°C")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Min: \(currentWeather.main.tempMin, specifier: "%.2f") °C")
                    Text("Max: \(currentWeather.main.tempMax, specifier: "%.2f") °C")
                    Text("Pressure: \(currentWeather.main.pressure) hPa")
                    Text("Humidity: \(currentWeather.main.humidity) %")
                }
                .foregroundColor(.white)
            }
            .padding(.horizontal, 80)
            .padding(.vertical, 20)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(currentWeather: Forecast.dummyWeather)
            .previewLayout(.sizeThatFits)
    }
}


// MARK: - Functions & Computed Properties
extension ForecastView {
    
    var conditionName: String {
        switch currentWeather.weather[0].id {
        case 200...232:
            return "cloud.bolt.fill"
        case 230...232:
            return "cloud.bold.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...504:
            return "cloud.sun.rain.fill"
        case 511...511:
            return "snowflake"
        case 520...531:
            return "cloud.heavyrain.fill"
        case 600...602:
            return "cloud.hail.fill"
        case 611...613:
            return "cloud.sleet.fill"
        case 615...622:
            return "cloud.snow.fill"
        case 701...781:
            return "wind"
        case 711...711:
            return "smoke.fill"
        case 721...721:
            return "sun.haze.fill"
        case 741...741:
            return "cloud.fog.fill"
        case 761...761:
            return "sun.dust.fill"
        case 781...781:
            return "tornado"
        case 800...800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "questionmark.circle"
        }
    }
    
}
