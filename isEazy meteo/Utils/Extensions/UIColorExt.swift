//
//  UIColorExt.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation
import UIKit

extension UIColor {
    
    static let defaultBackground: UIColor = UIColor(rgb: 0xE1E6E2)
    static let defaultGreen: UIColor = UIColor(rgb: 0x7CF29B)
    static let defaultBlue: UIColor = UIColor(rgb: 0xA1E9FF)
    static let defaultBlue2: UIColor = UIColor(rgb: 0x9DB9FC)
    static let defaultYellow: UIColor = UIColor(rgb: 0xF8FF91)
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.00, green: CGFloat(green) / 255.00, blue: CGFloat(blue) / 255.00, alpha: 1.00)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
