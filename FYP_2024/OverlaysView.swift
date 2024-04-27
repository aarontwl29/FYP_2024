import SwiftUI
import MapKit

struct OverlaysView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showAnimalAnnotations = false
    @State private var showOverlays = true
    
    var annotations: [CustomAnnotation]
    var region: MKCoordinateRegion
    
    var filteredAnnotations: [CustomAnnotation] {
        annotations.filter { annotation in
            // Always show .camera annotations
            annotation.type == .camera ||
            // Conditionally show .animal annotations based on the toggle state
            (showAnimalAnnotations && annotation.type == .animal)
        }
    }
    
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
                annotations: filteredAnnotations,
                region: region,
                showOverlays: $showOverlays
            )
            Button("Toggle Overlays (Filter Later on)") {
                showOverlays.toggle()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            
            Button("Toggle Animal Annotations") {
                            showAnimalAnnotations.toggle()
                        }
                        .padding()
                        .background(showAnimalAnnotations ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
        }
 
    }
}



struct PreviewSetup {
    static func createAnnotations() -> [CustomAnnotation] {
        var annotations: [CustomAnnotation] = [
            AnimalAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.390873, longitude: 114.198035), title: "San Francisco", subtitle: "Cat Spot", imageName: "image3", type: .animal),
            AnimalAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.394873, longitude: 114.198035), title: "San Francisco", subtitle: "Cat Spot", imageName: "img_bl_content2", type: .animal),
            AnimalAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.393873, longitude: 114.202035), title: "San Francisco", subtitle: "Dog Spot", imageName: "dog", type: .animal),
            CameraAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.396873, longitude: 114.198035), title: "San Francisco", subtitle: "Dog Spot", imageName: "camera", type: .camera),
            CameraAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.392873, longitude: 114.195535), title: "San Francisco", subtitle: "Dog Spot", imageName: "camera", type: .camera),
            CameraAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.388873, longitude: 114.200035), title: "San Francisco", subtitle: "Dog Spot", imageName: "camera", type: .camera),
            CameraAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.386473, longitude: 114.196035), title: "San Francisco", subtitle: "Dog Spot", imageName: "camera", type: .camera)
        ]
        if let cameraAnnotation = annotations[3] as? CameraAnnotation {cameraAnnotation.setPercentage(to: 70.0)}
        if let cameraAnnotation = annotations[4] as? CameraAnnotation {cameraAnnotation.setPercentage(to: 50.0)}
        if let cameraAnnotation = annotations[5] as? CameraAnnotation {cameraAnnotation.setPercentage(to: 30.0)}
        
        return annotations
    }
}
struct OverlaysView_Previews: PreviewProvider {
    static var previews: some View {
        let annotations = PreviewSetup.createAnnotations()
        OverlaysView(annotations: annotations,
                     region: MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 22.390873338752847, longitude: 114.19803500942166),
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    ))
    }
}






class CustomCircle: MKCircle {
    weak var customAnnotation: CustomAnnotation?
}

// Struct to represent a map view in SwiftUI using UIViewRepresentable
struct MapViewTest: UIViewRepresentable {
    // Properties
    var annotations: [CustomAnnotation]  // Dynamic array of custom annotations for the map
    let region: MKCoordinateRegion  // The initial region that the map will display
    @Binding var showOverlays: Bool  // Binding to control the visibility of overlays on the map

    // Create and configure the MKMapView
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator  // Set the delegate to the coordinator
        mapView.setRegion(region, animated: true)  // Set the initial region of the map
        mapView.addAnnotations(annotations)  // Add annotations to the map
        return mapView
    }

    // Update the map view when SwiftUI state changes
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)  // Remove all current annotations
        uiView.addAnnotations(annotations)  // Add current filtered annotations
        
        if showOverlays {
            updateOverlays(from: uiView)  // Update to show overlays
        } else {
            uiView.removeOverlays(uiView.overlays)  // Remove all overlays if not shown
        }
    }

    // Private method to update overlays based on annotations
    private func updateOverlays(from mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)  // Remove existing overlays
        let overlaysToShow = annotations.filter { annotation in
            shouldShowOverlay(for: annotation)  // Filter annotations that need overlays
        }.map { annotation in
//            MKCircle(center: annotation.coordinate, radius: 350)  
            // Create a circle overlay for each
            let circle = CustomCircle(center: annotation.coordinate, radius: 350)
            circle.customAnnotation = annotation  // Link the annotation
            return circle
        }
        mapView.addOverlays(overlaysToShow)  // Add new overlays to the map
    }

    // Determine whether to show an overlay for a specific annotation
    private func shouldShowOverlay(for annotation: CustomAnnotation) -> Bool {
        return annotation.type == .camera  // Example condition: only show for 'camera' type
    }

    // Create a coordinator that will manage map interactions
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Coordinator class to handle map view delegate methods
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewTest

        init(_ parent: MapViewTest) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let customCircle = overlay as? CustomCircle, let annotation = customCircle.customAnnotation {
                let circleRenderer = MKCircleRenderer(circle: customCircle)
                circleRenderer.lineWidth = 1
                circleRenderer.strokeColor = .black

                if annotation.type == .camera {
                    if let highlightValue = annotation.highlightValue {
                        switch highlightValue {
                        case let x where x > 60:
                            circleRenderer.fillColor = .red.withAlphaComponent(0.4)
                        case let x where x > 40:
                            circleRenderer.fillColor = .yellow.withAlphaComponent(0.4)
                        default:
                            circleRenderer.fillColor = .green.withAlphaComponent(0.4)
                        }
                    } else {
                        // Handle the case where highlightValue is nil
                        circleRenderer.fillColor = .gray.withAlphaComponent(0.2)
                    }
                }
                
                return circleRenderer
            }
            return MKOverlayRenderer(overlay: overlay)  // Default renderer for other types of overlays
        }
    }
}


class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapViewTest  // Reference to the parent UIViewRepresentable instance

    init(_ parent: MapViewTest) {
        self.parent = parent
    }

    // Provide a custom view for each annotation added to the map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Ensure the annotation is of type CustomAnnotation
        guard let customAnnotation = annotation as? CustomAnnotation else {
            return nil  // Return nil if the annotation isn't the expected type
        }

        let identifier = "CustomMarker"  // Reuse identifier for marker views
        var markerView: MKMarkerAnnotationView  // Declare the custom marker view variable

        // Try to dequeue an existing view first to reuse it
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation  // Assign the annotation to the dequeued view
            markerView = dequeuedView  // Use the dequeued view
        } else {
            // If no reusable view is available, create a new one
            markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }

        // Customize the marker using native properties
        markerView.glyphText = String(customAnnotation.title?.prefix(1) ?? "?")  // Use the first letter of the title as the glyph
        markerView.markerTintColor = .yellow  // Set the marker color to red
        markerView.titleVisibility = .hidden  // Ensure the title is always visible
        markerView.subtitleVisibility = .hidden  // Ensure the subtitle is always visible

        return markerView  // Return the custom marker view
    }
}






//// Custom annotation view for displaying annotations on a map
//class CustomAnnotationView: MKAnnotationView {
//    // Override the annotation property to customize the annotation view when it's set
//    override var annotation: MKAnnotation? {
//        willSet {
//            // Ensure the new annotation is of type CustomAnnotation
//            guard let customAnnotation = newValue as? CustomAnnotation else { return }
//            
//            // Enable the display of a callout when this view is tapped
//            canShowCallout = true
//            // Set the position of the callout bubble
//            calloutOffset = CGPoint(x: -5, y: 5)
//            // Add a button on the right side of the callout
//            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            
//            // Configure the frame and background color of the view
//            frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//            backgroundColor = .clear
//            
//            // Create an image view to show an image in the annotation
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//            imageView.layer.cornerRadius = imageView.frame.size.width / 2  // Make it circular
//            imageView.layer.masksToBounds = true  // Clip the image to the bounds of the image view
//            imageView.contentMode = .scaleAspectFill  // Maintain the aspect ratio of the image
//            
//            // Set the image from the annotation's imageName property, if available
//            if let imageName = customAnnotation.imageName {
//                imageView.image = UIImage(named: imageName)  // Load the image
//            }
//            
//            // Add the image view to the annotation view
//            addSubview(imageView)
//        }
//    }
//}


//// Coordinator class that acts as the delegate for MKMapView
//class Coordinator: NSObject, MKMapViewDelegate {
//    var parent: MapViewTest  // Reference to the parent UIViewRepresentable instance
//
//    // Initialize with a reference to the parent
//    init(_ parent: MapViewTest) {
//        self.parent = parent
//    }
//
//    // Provide a custom view for each annotation added to the map
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // Ensure the annotation is of type CustomAnnotation
//        guard let customAnnotation = annotation as? CustomAnnotation else {
//            return nil  // Return nil if the annotation isn't the expected type
//        }
//
//        let identifier = "CustomAnnotation"  // Reuse identifier for annotation views
//        var view: CustomAnnotationView  // Declare the custom annotation view variable
//
//        // Try to dequeue an existing view first to reuse it
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView {
//            dequeuedView.annotation = annotation  // Assign the annotation to the dequeued view
//            view = dequeuedView  // Use the dequeued view
//        } else {
//            // If no reusable view is available, create a new one
//            view = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//        }
//        
//        return view  // Return the custom annotation view
//    }
//
//    // Provide a renderer for each overlay added to the map
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        // Check if the overlay is a circle
//        if let circleOverlay = overlay as? MKCircle {
//            let circleRenderer = MKCircleRenderer(circle: circleOverlay)  // Create a renderer for the circle
//            circleRenderer.strokeColor = .blue  // Set the stroke color to blue
//            circleRenderer.fillColor = .blue.withAlphaComponent(0.3)  // Set the fill color to blue with transparency
//            circleRenderer.lineWidth = 1  // Set the line width to 1
//            return circleRenderer  // Return the configured circle renderer
//        }
//        // Return a default renderer for other types of overlays
//        return MKOverlayRenderer(overlay: overlay)
//    }
//}

