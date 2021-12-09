//
//  ForecastApp.swift
//  Forecast
//
//  Created by Damien Chailloleau on 06/12/2021.
//

import SwiftUI

@main
struct ForecastApp: App {
    @StateObject private var vm = ForecastViewModelImpl(service: ForecastServiceImpl())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
