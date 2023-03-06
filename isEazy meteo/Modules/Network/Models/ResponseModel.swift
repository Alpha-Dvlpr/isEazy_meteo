//
//  ResponseModel.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation

struct ResponseModel<T: Codable>: Codable {
    
    var isSuccess: Bool
    var message: String
    var error: ErrorModel { return ErrorModel(self.message) }
    var rawData: Data?
    var data: T?
    var json: String? {
        guard let rawData = self.rawData else { return nil }
        
        return String(data: rawData, encoding: String.Encoding.utf8)
    }
    var request: RequestModel?

    init() {
        self.isSuccess = false
        self.message = ""
    }
    
    init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.isSuccess = (try? keyedContainer.decode(Bool.self, forKey: CodingKeys.isSuccess)) ?? false
        self.message = (try? keyedContainer.decode(String.self, forKey: CodingKeys.message)) ?? ""
        self.data = try? keyedContainer.decode(T.self, forKey: CodingKeys.data)
    }
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case message
        case data
    }
}
