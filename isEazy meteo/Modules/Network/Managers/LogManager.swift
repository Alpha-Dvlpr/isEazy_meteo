//
//  LogManager.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Foundation

class LogManager {
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    private static var dateFormat = "hh:mm:ss"
    private static var isLoggingEnabled: Bool { return true }
    private static var date: String { return Date().toString() }
    
    class func e( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        guard self.isLoggingEnabled else { return }
        
        print("Log: \(self.date) \(LogType.e.rawValue)[\(self.sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)")
    }
    
    class func i( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        guard self.isLoggingEnabled else { return }
        
        print("Log: \(self.date) \(LogType.i.rawValue)[\(self.sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)")
    }
    
    class func d( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        guard self.isLoggingEnabled else { return }
        
        print("Log: \(self.date) \(LogType.d.rawValue)[\(self.sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)")
    }
    
    class func v( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        guard self.isLoggingEnabled else { return }
        
        print("Log: \(self.date) \(LogType.v.rawValue)[\(self.sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)")
    }
    
    class func w( _ object: Any?, filename: String = #file, line: Int = #line, funcName: String = #function) {
        guard self.isLoggingEnabled else { return }
        
        print("Log: \(self.date) \(LogType.w.rawValue)[\(self.sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object!)")
    }
    
    class func s( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        guard self.isLoggingEnabled else { return }
        
        print("Log: \(self.date) \(LogType.s.rawValue)[\(self.sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    class func req(_ request: RequestModel) {
        guard self.isLoggingEnabled else { return }
        
        let endpoint: String = request.endpoint
        let path: String = request.path
        let headers: String = String(describing: request.headers)
        let httpMethod: String = String(describing: request.method.rawValue)
        var body: String = ""
        var bodyStrings: [String] = []
        
        request.body.forEach {
            if let valueValue = $0.value {
                bodyStrings.append("\($0.key): \(type(of: valueValue))(\(valueValue))")
            } else {
                bodyStrings.append("\($0.key): nil")
            }
        }
        
        body = bodyStrings.joined(separator: ", ")
        
        var log: String = "[\(endpoint)\(path)]"
        
        if !request.headers.isEmpty { log += "\n\(headers)" }
        
        log += "\n[\(httpMethod)]"
        
        if !request.body.isEmpty { log += "\n[\(body)]" }
        
        print("LogManager: \n--- Request ---\n[\(Date().toString())] \n\(log) \n--- End ---\n")
    }
    
    class func res<T: Codable>(_ response: ResponseModel<T>) {
        guard self.isLoggingEnabled else { return }
        
        let endpoint: String? = response.request?.endpoint
        let path: String? = response.request?.path
        let isSuccess: Bool = response.isSuccess
        let message: String = response.message
        let dataJSON: String? = response.json
        
        var log: String = ""
        
        if let endpoint = endpoint, let path = path { log += "[\(endpoint)\(path)]\n" }
        
        log += "[isSuccess: \(isSuccess)]\n[message: \(message)]"
        
        if let json = dataJSON { log += "\n[\(json)]" }
        
        print("LogManager: \n--- Response ---\n[\(Date().toString())] \n\(log) \n--- End ---\n")
    }
    
    class func err(_ error: ErrorModel) {
        guard self.isLoggingEnabled else { return }
        
        let errorKey: String? = error.messageKey
        let errorMessage: String? = error.message
        
        var log: String = ""
        
        if let errorKey = errorKey { log += "\n[key: \(errorKey)]" }
        if let errorMessage = errorMessage { log += "\n[message: \(errorMessage)]" }
        
        if log.isEmpty { return }
        
        print("LogManager: \n--- Error ---\n[\(Date().toString())] \(log) \n--- End ---\n")
    }
}

private extension LogManager {
    
    class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
