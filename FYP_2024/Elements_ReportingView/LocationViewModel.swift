import Foundation
import SwiftUI
import MapKit

class LocationViewModel: NSObject, ObservableObject {
    @Published var selectedLocation: CLLocationCoordinate2D?
    private let locationManager = CLLocationManager()
    
    @Published var showLocationPicker = false

    override init() {
        super.init()
        locationManager.delegate = self
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else { return }
        selectedLocation = location
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
    }
}
