//
//  WeatherModel.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation

class WeatherModel: Codable {
    
    let dTime: Int
    let sunrise, sunset: Double
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [LittleWeather]
    let pop: Double
    let rain: RainModel
    
    enum CodingKeys: String, CodingKey {
        case dTime = "dt"
        case sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, pop, rain
    }
    
    init() {
        self.dTime = 0
        self.sunrise = 0.00
        self.sunset = 0.00
        self.temp = 0.00
        self.feelsLike = 0.00
        self.pressure = 0
        self.humidity = 0
        self.dewPoint = 0.00
        self.uvi = 0.00
        self.clouds = 0
        self.visibility = 0
        self.windSpeed = 0.00
        self.windDeg = 0
        self.windGust = 0.00
        self.weather = []
        self.pop = 0.00
        self.rain = RainModel()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
     
        self.dTime = try container.decodeIfPresent(Int.self, forKey: .dTime) ?? 0
        self.sunrise = try container.decodeIfPresent(Double.self, forKey: .sunrise) ?? 0.00
        self.sunset = try container.decodeIfPresent(Double.self, forKey: .sunset) ?? 0.00
        self.temp = try container.decodeIfPresent(Double.self, forKey: .temp) ?? 0.00
        self.feelsLike = try container.decodeIfPresent(Double.self, forKey: .feelsLike) ?? 0.00
        self.pressure = try container.decodeIfPresent(Int.self, forKey: .pressure) ?? 0
        self.humidity = try container.decodeIfPresent(Int.self, forKey: .humidity) ?? 0
        self.dewPoint = try container.decodeIfPresent(Double.self, forKey: .dewPoint) ?? 0.00
        self.uvi = try container.decodeIfPresent(Double.self, forKey: .uvi) ?? 0.00
        self.clouds = try container.decodeIfPresent(Int.self, forKey: .clouds) ?? 0
        self.visibility = try container.decodeIfPresent(Int.self, forKey: .visibility) ?? 0
        self.windSpeed = try container.decodeIfPresent(Double.self, forKey: .windSpeed) ?? 0.00
        self.windDeg = try container.decodeIfPresent(Int.self, forKey: .windDeg) ?? 0
        self.windGust = try container.decodeIfPresent(Double.self, forKey: .windGust) ?? 0.00
        self.weather = try container.decodeIfPresent([LittleWeather].self, forKey: .weather) ?? []
        self.pop = try container.decodeIfPresent(Double.self, forKey: .pop) ?? 0.00
        self.rain = try container.decodeIfPresent(RainModel.self, forKey: .rain) ?? RainModel()
    }
}
