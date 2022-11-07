//
//  CurrentWeather.swift
//  Weather
//
//  Created by Артём Тюрморезов on 03.11.2022.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return String(format:"%.0f",temperature)
    }
    let temperatureMin: Double
    var temperatureMinString: String {
        return String(format:"%.0f",temperatureMin)
    }
    let temperatureMax: Double
    var temperatureMaxString: String {
        return String(format:"%.0f", temperatureMax)
    }
    let feelsLike: Double
    var feelsLikeString: String {
        return String(format:"%.0f",feelsLike)
    }
    let description: String
    let windSpeed: Double
    var windSpeedString: String {
        return String(format:"%.0f",windSpeed)
    }
    
    let conditionCode: Int
    var iconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign.app.fill"
        }
    }
    
    init?(currentWeatherData: DataModel) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLike = currentWeatherData.main.feels_like
        temperatureMin = currentWeatherData.main.temp_min
        temperatureMax = currentWeatherData.main.temp_max
        conditionCode = currentWeatherData.weather.first?.id ?? 0
        description = currentWeatherData.weather.first?.description ?? ""
        windSpeed = currentWeatherData.wind.speed
    }
}
