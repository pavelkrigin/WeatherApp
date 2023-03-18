//
//  Constants.swift
//  WeatherApp
//
//  Created by Pavel Krigin on 25.02.2023.
//

import Foundation

final class Constants {
    
   static let shared: Constants = Constants()
    
    init() {}
    
    private let apiKey = "36b641236ecb3f0a4d7aec5e32ee2e21"
    private let url =  "https://api.openweathermap.org/data/2.5/weather?units=metric"
    
    func getBaseUrl(location: (Double, Double)) -> String {
        url + "&appid=\(apiKey)" + "&lat=\(location.0)&lon=\(location.1)"
    }
}
