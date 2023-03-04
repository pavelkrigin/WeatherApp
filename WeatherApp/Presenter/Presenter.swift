//
//  Presenter.swift
//  WeatherApp
//
//  Created by Pavel Krigin on 04.03.2023.
//

import Foundation



final class Presenter {
    
    private let dataSourse: APIDataSourse?
    weak private var weatherDelegate: WeatherDelegate?
    
    func setViewDelegate(weatherViewDelegate: WeatherDelegate) {
        
        weatherDelegate = weatherViewDelegate
    }
    
    func mappingData(apiModel: WeatherAPIModel) -> WeatherModel {
        return WeatherModel(temp: "\(apiModel.main.temp)˚")
        
    }
    
    func getWeatherData() {
        dataSourse?.getData(completion: { weatherAPIModel, error  in
            
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
