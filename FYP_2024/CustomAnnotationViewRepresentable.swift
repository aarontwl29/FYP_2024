import SwiftUI
import MapKit

struct CustomAnnotationViewRepresentable: UIViewRepresentable {
    let annotation: CustomAnnotation

    func makeUIView(context: Context) -> CustomAnnotationView {
        let annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.reuseIdentifier)
        return annotationView
    }

    func updateUIView(_ view: CustomAnnotationView, context: Context) {
    }
}
