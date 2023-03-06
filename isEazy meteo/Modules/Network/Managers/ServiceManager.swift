//
//  ServiceManager.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation

class ServiceManager: Manager {
    
    static let shared: ServiceManager = ServiceManager()
    
    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping ((Swift.Result<T, ErrorModel>) -> Void)) {
        if request.isLoggingEnabled.0 { LogManager.req(request) }
        
        func logError(with message: String) {
            let error = ErrorModel(message)
            LogManager.err(error)
            completion(.failure(error))
        }
        
        URLSession.shared.dataTask(with: request.urlRequest()) { (data, _, error) in
            if error != nil { logError(with: ErrorKey.general.rawValue); return }
            
            guard let data = data else { logError(with: ErrorKey.notFound.rawValue); return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(decoded))
            } catch DecodingError.keyNotFound(let key, let context) {
                logError(with: "Could not find key \(key) in JSON: \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                logError(with: "Could not find type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.typeMismatch(let type, let context) {
                logError(with: "Type mismatch for type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(let context) {
                logError(with: "Data found to be corrupted in JSON: \(context.debugDescription)")
            } catch let error as NSError {
                logError(with: "Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            }
        }.resume()
    }
}
