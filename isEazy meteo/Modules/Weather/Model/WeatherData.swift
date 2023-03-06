//
//  WeatherData.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import CoreLocation
import Foundation

class WeatherData: Codable {
    
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let hourly: [WeatherModel]
    var cityName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone, hourly
        case timezoneOffset = "timezone_offset"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.lat = try container.decodeIfPresent(Double.self, forKey: .lat) ?? 0.00
        self.lon = try container.decodeIfPresent(Double.self, forKey: .lon) ?? 0.00
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone) ?? ""
        self.timezoneOffset = try container.decodeIfPresent(Int.self, forKey: .timezoneOffset) ?? 0
        self.hourly = try container.decodeIfPresent([WeatherModel].self, forKey: .hourly) ?? []
    }
}
