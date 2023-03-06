//
//  DateExt.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import Foundation

extension Date {
    
    func toString() -> String { return LogManager.dateFormatter.string(from: self as Date) }
    
    func toHourString(showSeconds: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = showSeconds ? "HH:mm:ss" : "HH:mm"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        
        return formatter.string(from: self as Date)
    }
}
