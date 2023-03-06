//
//  CoreDataController.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation

class CoreDataController {
    
    static let shared: CoreDataController = CoreDataController()
    
    func saveAPIKey() {
        UserDefaults.standard.set("708c0f6d7e119cd8d48842309df95153", forKey: CoreDataKeys.APIKey.rawValue)
    }
    
    func getAPIKey() -> String {
        return UserDefaults.standard.string(forKey: CoreDataKeys.APIKey.rawValue) ?? ""
    }
}
