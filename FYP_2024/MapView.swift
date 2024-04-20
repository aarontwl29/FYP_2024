import SwiftUI
import MapKit

struct CustomAnnotationViewRepresentable: UIViewRepresentable {
    let annotation: CustomAnnotation

    func makeUIView(context: Context) -> CustomAnnotationView {
        return CustomAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.reuseIdentifier)
    }

    func updateUIView(_ view: CustomAnnotationView, context: Context) {
        // No updates needed
    }
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.390873338752847, longitude: 114.19803500942166),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var searchText = ""
    private var annotations: [CustomAnnotation] {
        [
            CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.390873338752847, longitude: 114.19803500942166), title: "Cat 1", imageName: "cat"),
            CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.391873338752847, longitude: 114.19903500942166), title: "Cat 2", imageName: "cat")
        ]
    }

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: annotations) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    CustomAnnotationViewRepresentable(annotation: annotation)
                }
            }.ignoresSafeArea()
            VStack {
                Map_SearchBar(searchText: $searchText)
                    .padding(.top, 0)
                    .padding(.horizontal)
                Spacer()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
