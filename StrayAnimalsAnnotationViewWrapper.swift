import SwiftUI
import MapKit

struct StrayAnimalsAnnotationViewWrapper: View {
    var annotation: StrayAnimalsAnnotation
    
    var body: some View {
        StrayAnimalsAnnotationView(annotation: annotation, reuseIdentifier: StrayAnimalsAnnotationView.reuseIdentifier)
    }
}

#Preview {
    StrayAnimalsAnnotationViewWrapper()
}
