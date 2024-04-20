import MapKit

class CustomAnnotation: NSObject, MKAnnotation, Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let imageName: String?

    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil, imageName: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        super.init()
    }
}
