import SwiftUI
import MapKit





struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.390873338752847, longitude: 114.19803500942166),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var searchText = ""
    @State private var selectedAnnotation: CustomAnnotation?

    let annotations: [CustomAnnotation] = [
        CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.390873, longitude: 114.198035), title: "San Francisco", imageName: "cat", type: .animal),
        CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.400873, longitude: 114.198035), title: "San Francisco", imageName: "dog", type: .animal)
    ]

    var body: some View {
            ZStack {
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil, annotationItems: annotations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Circle()
                            .stroke(Color.gray, lineWidth: 0.5)
                            .fill(.blue)
                            .frame(width: 35, height: 35)
                            .overlay {
                                if let imageName = location.imageName {
                                                Image(imageName)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                                                    .clipShape(Circle())
                                            }
                            }
                            .scaleEffect(1.8)
                            .onTapGesture {
                                self.selectedAnnotation = location
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
            .fullScreenCover(item: $selectedAnnotation, content: {
                annotation in AnimalDetailsView()
            })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
