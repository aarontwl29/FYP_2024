import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.390873338752847, longitude: 114.19803500942166),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var searchText = ""

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region).edgesIgnoringSafeArea(.all)
            VStack {
                Map_SearchBar(searchText: $searchText) // Pass the binding here
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
