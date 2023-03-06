//
//  WeatherRequest.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation

class WeatherRequest: RequestModel {
    
    var lat: String
    var lon: String
    
    init(lat: String, lon: String) {
        self.lat = lat
        self.lon = lon
    }
    
    override var endpoint: String { return Endpoints.weather.rawValue }
    override var parameters: [String: Any?] {
        return [
            "lat": self.lat,
            "lon": self.lon,
            "exclude": "minutely,current,daily,alerts",
            "units": "metric",
            "lang": Locale.current.languageCode ?? "es",
            "appid": CoreDataController.shared.getAPIKey()
        ]
    }
}
