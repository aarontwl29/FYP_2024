import SwiftUI
import MapKit

class MapViewController: UIViewController {
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
}

struct LocationPickerView: UIViewControllerRepresentable {
    @ObservedObject var locationViewModel: LocationViewModel

    func makeUIViewController(context: UIViewControllerRepresentableContext<LocationPickerView>) -> MapViewController {
        let mapViewController = MapViewController()
        mapViewController.mapView.delegate = context.coordinator
        return mapViewController
    }

    func updateUIViewController(_ uiViewController: MapViewController, context: UIViewControllerRepresentableContext<LocationPickerView>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: LocationPickerView

        init(_ parent: LocationPickerView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation {
                parent.locationViewModel.selectedLocation = annotation.coordinate
            }
        }
    }
}

#Preview {
    LocationPickerView(locationViewModel: LocationViewModel())
}
