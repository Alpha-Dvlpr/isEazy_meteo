//
//  WeatherVM.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import Bond
import CoreLocation
import Foundation

class WeatherVM: AnyVM {
    
    var netServices: Service?
    var manager: CLLocationManager?
    var authorizationStatus = Observable<CLAuthorizationStatus>(.notDetermined)
    var data = Observable<WeatherData?>(nil)
    var state = Observable<AppState>(.idle)
    
    init(service: Service) {
        self.manager = CLLocationManager()
        self.data.value = nil
        self.state.value = .idle
        self.netServices = service
    }
    
    func setDelegate(_ delegate: CLLocationManagerDelegate) {
        self.manager?.delegate = delegate
    }
    
    func requestPermission() {
        self.manager?.requestWhenInUseAuthorization()
    }
    
    func getData() {
        let lat: String = String(format: "%f", self.manager?.location?.coordinate.latitude ?? .zero)
        let lon: String = String(format: "%f", self.manager?.location?.coordinate.longitude ?? .zero)
        
        self.state.value = .loading
        self.netServices?.getWeatherList(lat: lat, lon: lon) { [ weak self ] result in
            guard let wSelf = self else { return }
            
            switch result {
            case .success(let data):
                CLGeocoder().reverseGeocodeLocation(
                    CLLocation(
                        latitude: Double(lat) ?? 0.00,
                        longitude: Double(lon) ?? 0.00
                    )
                ) { [ weak self ] ( placemarks, _ ) in
                    guard let wSelf = self else { wSelf.state.value = .error(error: ErrorModel.generalError()); return }
                    
                    let temp = data
                    temp.cityName = placemarks?.first?.locality ?? ""
                    
                    wSelf.data.value = temp
                    wSelf.state.value = .idle
                }
            case .failure(let error):
                wSelf.state.value = .error(error: error)
            }
        }
    }
}
