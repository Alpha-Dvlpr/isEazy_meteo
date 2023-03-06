//
//  URLImage.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import Foundation

protocol URLImage {
    
    func loadImage(from url: URL?, completion: URLImageCompletion?)
    func clear()
}
