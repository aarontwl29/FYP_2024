import Foundation
import SwiftUI
import MapKit

class LocationViewModel: NSObject, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var selectedLocation: CLLocationCoordinate2D?
    @Published var locationUpdated = false
    private let locationManager = CLLocationManager()
    
    @Published var showLocationPicker = false

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func selectLocationFromMap() {
        showLocationPicker = true
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            // Handle denied or restricted access
            break
        case .notDetermined:
            // Request authorization again if needed
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
    }
}
