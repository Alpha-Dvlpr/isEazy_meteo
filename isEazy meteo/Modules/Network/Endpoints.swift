//
//  Endpoints.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation

enum Endpoints {
    
    case weather
    case icon(id: String)
    
    var rawValue: String {
        switch self {
        case .weather:
            return "https://api.openweathermap.org/data/2.5/onecall"
        case .icon(let id):
            return "https://openweathermap.org/img/wn/\(id)@2x.png"
        }
    }
}
