//
//  RainModel.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import Foundation

class RainModel: Codable {
    
    var hourly: Double
    
    enum CodingKeys: String, CodingKey {
        case hourly = "1h"
    }
    
    init() { self.hourly = 0.00 }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.hourly = try container.decodeIfPresent(Double.self, forKey: .hourly) ?? 0.00
    }
}
