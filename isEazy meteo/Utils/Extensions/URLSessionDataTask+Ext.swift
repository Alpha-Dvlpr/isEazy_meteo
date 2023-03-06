//
//  URLSessionDataTask+Ext.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import Foundation

extension URLSessionDataTask: Disposable {
    
    func dispose() { self.cancel() }
}
