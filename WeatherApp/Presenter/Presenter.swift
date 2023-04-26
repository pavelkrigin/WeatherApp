//
//  Presenter.swift
//  WeatherApp
//
//  Created by Pavel Krigin on 26.04.2023.
//

import Foundation


final class Presenter {
    
    private let dataSourse: APIDataSourse?
    
    let locationManager = LocationManager()
    
    weak private var weatherDelegate: WeatherDelegate?
    
    func setViewDelegate(weatherViewDelegate: WeatherDelegate) {
        weatherDelegate = weatherViewDelegate
        locationManager.setUpLocationManager()
    }
    
    func mappingData(apiModel: WeatherAPIModel) -> WeatherModel {
        return WeatherModel(temp: "\(apiModel.main.temp)˚",
                            country: apiModel.sys.country)
    }
    
    func getWeatherData() {
        
        dataSourse?.getData(location: locationManager.location, completion: { weatherAPIModel, error  in
            
            if let weatherAPIModel = weatherAPIModel {
                let viewModel = self.mappingData(apiModel: weatherAPIModel)
                self.weatherDelegate?.displayWeatherData(model: viewModel)
            } else {
                self.weatherDelegate?.displayError(error: error ?? "unknown error")
            }
        })
    }
    
    init(dataSourse: APIDataSourse?) {
        self.dataSourse = dataSourse
    }
    
}

