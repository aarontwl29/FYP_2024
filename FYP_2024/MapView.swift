import SwiftUI
import MapKit

struct Wrapper: Codable {
    let items: [Animal]
}
struct Animal: Codable, Identifiable {
    let id: String
    let image: String
    let gender: String
    let color: String
    let nickName: String
    let latitude: Double
    let description: String
    let type: String
    let animalId: String
    let breed: String
    let neuteredStatus: String
    let healthStatus: String
    let age: Int
    let longitude: Double
}
func performAPICall() async throws -> [Animal] {
    let url = URL(string: "https://fyp2024.azurewebsites.net/animals")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode([Animal].self, from: data)
    return wrapper
}


struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.390873338752847, longitude: 114.19803500942166),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var selectedAnnotation: CustomAnnotation?
    @State private var circleOverlays: [MKCircle] = []
    
    @State private var searchText = ""
    
    @State private var showReportingView = false
    
    
    

    let annotations: [CustomAnnotation] = [
        CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.390873, longitude: 114.198035), title: "San Francisco", imageName: "cat", type: .animal),
        CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.396873, longitude: 114.198035), title: "San Francisco", imageName: "dog", type: .animal)
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
                }
                .ignoresSafeArea()
                .overlay(
                    Group {
                        ForEach(circleOverlays, id: \.self) { circle in
                            Circle()
                                .stroke(Color.blue, lineWidth: 2)
                                .fill(Color.blue.opacity(0.3))
                                .frame(width: circle.radius * 2, height: circle.radius * 2)
                                .offset(x: circle.coordinate.longitude - region.center.longitude, y: circle.coordinate.latitude - region.center.latitude)
                                .allowsHitTesting(false)
                        }
                    }
                )
                
                
                
                VStack {
                    Map_SearchBar(searchText: $searchText)
                        .padding(.top, 0)
                        .padding(.horizontal)
                    Spacer()
                    
                    Button(action: {
                                        addCircleOverlay()
                    }) {
                        Text("Highlight Area")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        showReportingView = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().fill(Color.blue))
                            .padding(.bottom, 30)
                    }
                }
            }
            .fullScreenCover(item: $selectedAnnotation, content: {
                annotation in AnimalDetailsView(selectedAnnotation: $selectedAnnotation)
            })
            .sheet(isPresented: $showReportingView) {
                ReportingView()
            }
    }
    
    func addCircleOverlay() {
        circleOverlays = annotations.map { annotation in
            MKCircle(center: annotation.coordinate, radius: 500) // radius in meters
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
