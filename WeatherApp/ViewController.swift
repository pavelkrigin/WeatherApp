//
//  ViewController.swift
//  WeatherApp
//
//  Created by Pavel Krigin on 25.02.2023.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var getWeatherButton: UIButton!

    func getData(completion: @escaping (WeatherModel)->()) {
        guard let url = URL(string: Constants.shared.getBaseUrl()) else { // guard
            print("URL Error")
            return
        }
        print(url)
        var request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }

            do {
                let response = try JSONDecoder().decode(WeatherAPIModel.self, from: data)
                DispatchQueue.main.async {
                    
                    completion(self.mappingData(apiModel: response))
                    
                }
                

            } catch let error {
                 
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func mappingData(apiModel: WeatherAPIModel) -> WeatherModel {
        return WeatherModel(temp: "\(apiModel.main.temp)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func getWeatherAction(_ sender: Any) {
        getData(completion: { model in
                self.weatherLabel.text = model.temp
            
        })
    }
}

