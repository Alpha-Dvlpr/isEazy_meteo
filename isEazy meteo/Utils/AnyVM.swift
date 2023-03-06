//
//  AnyVM.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Bond
import Foundation

protocol AnyVM: AnyObject {
    
    var netServices: Service? { get set }
    var data: Observable<WeatherData?> { get set }
    var state: Observable<AppState> { get set }
    
    func getData()
}
