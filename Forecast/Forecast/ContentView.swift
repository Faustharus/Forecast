//
//  ContentView.swift
//  Forecast
//
//  Created by Damien Chailloleau on 06/12/2021.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @EnvironmentObject var vm: ForecastViewModelImpl
    @State private var queryName: String = ""
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UISearchTextField.appearance().backgroundColor = .white
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(stops: [.init(color: Color(red: 0.3, green: 0.0, blue: 0.7), location: 0.33), .init(color: Color(red: 0.0, green: 0.15, blue: 1.0), location: 0.7)], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
                VStack {
                    ForecastView(currentWeather: vm.weather)
                    ScrollView {
                        weekDayForecast
                    }
                }
                .navigationTitle("Forecast")
                .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $queryName)
            .onSubmit(of: .search) {
                Task {
                    await fetchCurrentWeather(queryName: queryName)
                    await fetchCurrentWeekWeather(queryName: queryName)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ForecastViewModelImpl(service: ForecastServiceImpl()))
    }
}

// MARK: - View Component
extension ContentView {
    
    private var weekDayForecast: some View {
        VStack {
            ForEach(vm.weatherWeek, id: \.dt) { item in
                ZStack(alignment: .center) {
                    Rectangle().fill(.clear)
                    HStack {
                        Text("\(Date.init(timeIntervalSince1970: TimeInterval(item.dt)), format: .dateTime.weekday())")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: conditionName)
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Spacer()
                        
                        Text("\(item.temp.day, specifier: "%.2f") °C")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 90)
                }
                .frame(width: 400, height: 50)
            }
        }
    }
    
}


// MARK: - Functions & Computed Properties
extension ContentView {
    
    func fetchCurrentWeather(queryName: String) async {
        let queryName = queryName.replacingOccurrences(of: " ", with: "+")
        await vm.fetchWeather(queryName)
    }
    
    func fetchCurrentWeekWeather(queryName: String) async {
        let geoCoder = CLGeocoder()
        let queryName = queryName.replacingOccurrences(of: " ", with: "+")
        do {
            let getLocation = try await geoCoder.geocodeAddressString(queryName)
            guard
                let lat = getLocation.first?.location?.coordinate.latitude,
                let lon = getLocation.first?.location?.coordinate.longitude else {
                    return
                }
            await vm.fetchWeekWeather(lat, lon)
        } catch {
            print("Error Detected : \(error.localizedDescription)")
        }
    }
    
    var conditionName: String {
        switch vm.weatherWeek[0].weather[0].id {
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
