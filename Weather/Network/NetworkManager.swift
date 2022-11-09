//
//  NetworkManager.swift
//  Weather
//
//  Created by Артём Тюрморезов on 03.11.2022.
//

import Foundation
import UIKit
import CoreLocation



enum ResultError: Error {
    case invalidUrl
    case missingData
}

class NetworkManager {
    
    enum RequestType {
        case city(city: String)
        case location(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    func fetchData(requestType: RequestType ,completion: @escaping(Result<DataModel, Error>) -> Void) {
        
        var urlString = ""
        
        switch requestType {
        case .city(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .location(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&apikey=\(apiKey)&units=metric"
        }
        
       guard let url = URL(string: urlString) else {
            completion(.failure(ResultError.invalidUrl))
                    return
                }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                            completion(.failure(error))
                            return
                        }
            guard let data = data else {
                           completion(.failure(ResultError.missingData))
                           return
                       }
            do {
                let result = try JSONDecoder().decode(DataModel.self, from: data)
                            completion(.success(result))
                
                        } catch {
                            completion(.failure(error))
                        }
        }.resume()
    }
    
    
}

