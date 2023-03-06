//
//  Service.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation

typealias WeatherResponse = ((Swift.Result<WeatherData, ErrorModel>) -> Void)

protocol Service {
    
    var manager: Manager! { get set }
    
    func getWeatherList(lat: String, lon: String, completion: @escaping WeatherResponse)
}
