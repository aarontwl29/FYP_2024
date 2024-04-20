import SwiftUI
import MapKit

struct CustomAnnotationViewRepresentable: UIViewRepresentable {
    var annotation: CustomAnnotation
    @Binding var showNewView: Bool
    @Binding var annotationType: AnnotationType?

    func makeUIView(context: Context) -> MKAnnotationView {
        let view = CustomAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.reuseIdentifier)
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: MKAnnotationView, context: Context) {
        // Update the view if necessary
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, CustomAnnotationViewDelegate {
        var parent: CustomAnnotationViewRepresentable

        init(_ parent: CustomAnnotationViewRepresentable) {
            self.parent = parent
        }

        func annotationView(_ view: CustomAnnotationView, didTapAnnotationType type: AnnotationType?) {
            parent.showNewView = true
            parent.annotationType = type
        }
    }
}
