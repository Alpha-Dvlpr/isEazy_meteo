//
//  LittleWeather.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation
import UIKit

class LittleWeather: Codable {
    
    let id: Int
    let main, description, icon: String
    var color: UIColor {
        switch self.id {
        case 200..<300: return .defaultYellow
        case 300..<400, 600..<700: return .white
        case 500..<600: return .defaultBlue2
        case 801..<810: return .defaultBackground
        default: return .defaultGreen
        }
    }
    var imageURL: URL? { return URL(string: Endpoints.icon(id: self.icon).rawValue) }
    
    enum CodingKeys: String, CodingKey {
        case id, main, description, icon
    }
    
    init() {
        self.id = 0
        self.main = ""
        self.description = ""
        self.icon = ""
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.main = try container.decodeIfPresent(String.self, forKey: .main) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.icon = try container.decodeIfPresent(String.self, forKey: .icon) ?? ""
    }
}
