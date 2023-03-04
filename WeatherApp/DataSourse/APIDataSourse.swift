//
//  APIDataSourse.swift
//  WeatherApp
//
//  Created by Pavel Krigin on 04.03.2023.
//

import Foundation

final class APIDataSourse {
    
    func getData(completion: @escaping (WeatherAPIModel?, String?) -> ()) {
        guard let url = URL(string: Constants.shared.getBaseUrl()) else { // guard
            DispatchQueue.main.async {
                completion(nil, "URL Error")
            }
            return
        }
        print(url)
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error?.localizedDescription ?? "Unknown error")
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(WeatherAPIModel.self, from: data)
                DispatchQueue.main.async {
                    
                    completion(response, nil)
                    
                }
                
                
            } catch let error {
                
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
