//
//  ViewController.swift
//  WeatherApp
//
//  Created by Pavel Krigin on 25.02.2023.
//

import UIKit

protocol WeatherDelegate: AnyObject {
    func displayWeatherData(model: WeatherModel)
    func displayError(error: String)
    
}

final class ViewController: UIViewController, WeatherDelegate {
    
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var getWeatherButton: UIButton!
    let activityIndicator = UIActivityIndicatorView()
    
    private let presenter = Presenter(dataSourse: APIDataSourse())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(weatherViewDelegate: self)
        setUpActivityIndicator()
    }
    
    func setUpActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    func displayWeatherData(model: WeatherModel) {
        self.weatherLabel.text = model.temp
        activityIndicator.stopAnimating()
    }
    
    func displayError(error: String) {
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
        activityIndicator.stopAnimating()
    }
    
    @IBAction func getWeatherAction(_ sender: Any) {
        activityIndicator.startAnimating()
        presenter.getWeatherData()
    }
}
