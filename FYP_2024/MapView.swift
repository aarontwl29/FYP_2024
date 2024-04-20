import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.390873338752847, longitude: 114.19803500942166),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var searchText = ""
    let annotations: [CustomAnnotation] = [
            CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.390873338752847, longitude: 114.19803500942166), title: "San Francisco", imageName: "cat")
        ]

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
