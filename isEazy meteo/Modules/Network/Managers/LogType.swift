//
//  LogType.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import Foundation

// swiftlint:disable identifier_name
enum LogType: String {
    
    case e = "[‼️]" // error
    case i = "[ℹ️]" // info
    case d = "[💬]" // debug
    case v = "[🔬]" // verbose
    case w = "[⚠️]" // warning
    case s = "[🔥]" // severe
}
