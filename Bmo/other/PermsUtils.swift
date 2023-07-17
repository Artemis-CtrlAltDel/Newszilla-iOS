//
//  PermsUtils.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 12/7/2023.
//

import Foundation
import CoreLocation

class PermsUtils {
    
    class Location: NSObject, CLLocationManagerDelegate {
        
        private let locationManager = CLLocationManager()
        
        override init() {
            super.init()
            locationManager.delegate = self
            
            requestLocationPermission()
        }
        
        func requestLocationPermission() {
            locationManager.requestWhenInUseAuthorization()
        }
        
        func locationManagerDidChangeAuthorization() -> Bool {
            
            var isPermitted = false
            
            switch locationManager.authorizationStatus {
                case .authorizedWhenInUse:
                    isPermitted = true
                    print("location permission granted")
                case .denied:
                    isPermitted = false
                    print("location permission denied")
                default:
                    isPermitted = false
                    break
                }
            
            return isPermitted
        }
    }
    
    
}
