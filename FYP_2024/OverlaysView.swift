import SwiftUI
import MapKit

struct OverlaysView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showOverlays = true
    
    var body: some View {
   
        VStack {
            
            Button(action: {
                // Dismiss the current view
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundStyle(.black)
            }
            .padding(.leading, 20)
            .padding(.bottom, 10)
            
            
            
            MapViewTest(
                annotations: [
                    CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.390873, longitude: 114.198035), title: "San Francisco", subtitle: "Cat Spot", imageName: "cat", type: .animal),
                    CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.396873, longitude: 114.198035), title: "San Francisco", subtitle: "Dog Spot", imageName: "dog", type: .camera),
                    CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.394873, longitude: 114.198035), title: "San Francisco", subtitle: "Cat Spot", imageName: "cat", type: .animal),
                    CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.393873, longitude: 114.202035), title: "San Francisco", subtitle: "Dog Spot", imageName: "dog", type: .animal)
                ],
                region: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 22.390873, longitude: 114.198035),
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                ),
                showOverlays: $showOverlays
            )
            Button("Toggle Overlays (Filter Later on)") {
                showOverlays.toggle()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}







struct MapViewTest: UIViewRepresentable {
    let annotations: [CustomAnnotation]
    let region: MKCoordinateRegion
    @Binding var showOverlays: Bool  // Binding to control overlay visibility

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        mapView.addAnnotations(annotations)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if showOverlays {
            updateOverlays(from: uiView)
        } else {
            uiView.removeOverlays(uiView.overlays)
        }
    }

    private func updateOverlays(from mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        let overlaysToShow = annotations.filter { annotation in
            shouldShowOverlay(for: annotation)
        }.map { annotation in
            MKCircle(center: annotation.coordinate, radius: 300) // Adjust radius as needed
        }
        mapView.addOverlays(overlaysToShow)
    }

    private func shouldShowOverlay(for annotation: CustomAnnotation) -> Bool {
        // Only show overlay for annotations of type .animal
        return annotation.type == .animal
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewTest

        init(_ parent: MapViewTest) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circleOverlay = overlay as? MKCircle {
                let circleRenderer = MKCircleRenderer(circle: circleOverlay)
                circleRenderer.strokeColor = .blue
                circleRenderer.fillColor = .blue.withAlphaComponent(0.3)
                circleRenderer.lineWidth = 1
                return circleRenderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}


class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapViewTest

        init(_ parent: MapViewTest) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let customAnnotation = annotation as? CustomAnnotation else {
                return nil
            }

            let identifier = "CustomAnnotation"
            var view: CustomAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            
            return view
        }


    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: circleOverlay)
            circleRenderer.strokeColor = .blue
            circleRenderer.fillColor = .blue.withAlphaComponent(0.3)
            circleRenderer.lineWidth = 1
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}





class CustomAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let customAnnotation = newValue as? CustomAnnotation else { return }
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            // Set up the annotation view's frame and background
            frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            backgroundColor = .clear
            
            // Create an image view to display the image
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFill
            
            // Set the image based on the annotation's imageName property
            if let imageName = customAnnotation.imageName {
                imageView.image = UIImage(named: imageName)
            }
            
            addSubview(imageView)
        }
    }
}






#Preview {
    OverlaysView()
}
