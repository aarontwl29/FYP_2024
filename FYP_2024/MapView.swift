import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.390873338752847, longitude: 114.19803500942166),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var searchText = ""
    @State private var showNewView = false
    @State private var selectedAnnotation: CustomAnnotation?
    let annotations: [CustomAnnotation] = [
        CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.390873, longitude: 114.198035), title: "San Francisco", imageName: "cat", type: .animal)
        // Add more annotations if needed
    ]

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: annotations) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    Circle()
                        .strokeBorder(Color.blue, lineWidth: 2)
                        .background(Circle().foregroundColor(annotation.type == .animal ? Color.green : Color.red))
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            self.selectedAnnotation = annotation
                            self.showNewView = true
                        }
                }
            }.ignoresSafeArea()
            VStack {
                Map_SearchBar(searchText: $searchText)
                    .padding(.top, 0)
                    .padding(.horizontal)
                Spacer()
            }
        }
        .sheet(isPresented: $showNewView) {
            // Ensure that this closure always returns a View.
            if let selectedAnnotation = selectedAnnotation {
                FilterView()
            } else {
                // Provide a default view in case selectedAnnotation is nil.
                Text("No annotation selected")
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
