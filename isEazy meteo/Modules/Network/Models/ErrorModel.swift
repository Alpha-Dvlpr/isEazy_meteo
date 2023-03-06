//
//  ErrorModel.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation

class ErrorModel: Error {
    
    var messageKey: String
    var message: String { return self.messageKey }
    
    init(_ messageKey: String) { self.messageKey = messageKey }
    
    class func generalError() -> ErrorModel { return ErrorModel(ErrorKey.general.rawValue) }
}
