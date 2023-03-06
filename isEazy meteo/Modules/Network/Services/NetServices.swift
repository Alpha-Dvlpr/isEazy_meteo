//
//  NetServices.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation

class NetServices: Service {
    
    var manager: Manager!
    
    func getWeatherList(lat: String, lon: String, completion: @escaping WeatherResponse) {
        let model = WeatherRequest(lat: lat, lon: lon)
        self.manager.sendRequest(request: model, completion: completion)
    }
}
