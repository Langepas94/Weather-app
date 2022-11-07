//
//  NetworkManager.swift
//  Weather
//
//  Created by Артём Тюрморезов on 03.11.2022.
//

import Foundation
import UIKit

enum ResultError: Error {
    case invalidUrl
    case missingData
}

class NetworkManager {
    private let apiKey = "7af63772b9ed73068bec766f73b1724c"

//    func getWeather() {
//
//        var urls = "https://api.openweathermap.org/data/2.5/weather?q=Moscow&apikey=\(apiKey)&units=metric"
//
//        var reguest = URLRequest(url: URL(string: urls)!)
//        let session = URLSession.shared
//        let task = session.dataTask(with: reguest) { data, response, error in
//            do {
//                let json = try JSONDecoder().decode(DataModel.self, from: data!)
//                print(json)
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
//
//
//
//    }
    
    func fetchData(completion: @escaping(Result<DataModel, Error>) -> Void) {
       guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Langepas&appid=\(apiKey)&units=metric") else {
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
                            // Parse the JSON data
                let result = try JSONDecoder().decode(DataModel.self, from: data)
                            completion(.success(result))
                
                        } catch {
                            completion(.failure(error))
                        }
            
        }.resume()
    }
    
    
}

