//
//  DoubleExt.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import Foundation

extension Double {
    
    func toTemp() -> String { return String.init(format: "%.2f", self).appending(" ºC") }
}
