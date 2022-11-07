//
//  DataModel.swift
//  Weather
//
//  Created by Артём Тюрморезов on 03.11.2022.
//

import Foundation

struct ResultResponce: Codable {
    var responce: [DataModel]
}

struct DataModel: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct Wind: Codable {
    let speed: Double
}

//struct WeatherData: Codable {
//    var name: String = ""
//    var main: Main = Main()
//    var weather: [Weather] = []
//}
//
//struct Main: Codable {
//    var temp: Double = 0.0
//    var feelsLike: Double = 0.0
//    var tempString: String {
//        return String(format: "%.0f", temp )
//    }
//    var feelsLikeString: String {
//        return String(format: "%.0f", feelsLike )
//    }
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//    }
//}
//
//struct Weather: Codable {
//    var id: Int = 0
//
//    }



// Погода сейчас
// Ощущается
// Мин и макс
// Скорость ветра
// Иконка погоды
