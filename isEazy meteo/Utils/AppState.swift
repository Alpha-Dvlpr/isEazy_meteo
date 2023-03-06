//
//  AppState.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import Foundation

enum AppState {
    
    case idle
    case loading
    case error(error: Error)
}
