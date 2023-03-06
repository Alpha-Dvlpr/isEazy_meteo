//
//  Localize.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import Foundation

struct Localize {
    
    struct Base {
        static let info   = Localize.string("alpha.dvlpr.isEazy.meteo.strings.base.info")
        static let accept = Localize.string("alpha.dvlpr.isEazy.meteo.strings.base.accept")
        static let retry  = Localize.string("alpha.dvlpr.isEazy.meteo.strings.base.retry")
    }
    
    struct Permissions {
        static let button     = Localize.string("alpha.dvlpr.isEazy.meteo.strings.permissions.button")
        static let disclaimer = Localize.string("alpha.dvlpr.isEazy.meteo.strings.permissions.disclaimer")
    }
    
    static func string(_ key: String) -> String { return NSLocalizedString(key, comment: "") }
}
