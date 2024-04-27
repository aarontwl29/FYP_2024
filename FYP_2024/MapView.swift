import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 22.390873338752847, longitude: 114.19803500942166),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    @State private var selectedAnnotation: CustomAnnotation?
    
    @State private var searchText = ""
        
    @State private var showReportingView = false
    @State private var showOverlaysView = false
        

    @State private var annotations: [CustomAnnotation] = []
    var animalCount: Int {
        annotations.filter { $0.type == .animal }.count
    }


    
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
                            
                            let newCenter = CLLocationCoordinate2D(
                                        latitude: location.coordinate.latitude - 0.003,  // Adjust latitude for display
                                        longitude: location.coordinate.longitude
                            )
 
                            region = MKCoordinateRegion(
                                center: newCenter,
                                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                            )
                        }
                }
            }
            .ignoresSafeArea()

            
            
                    
            VStack {
                Map_SearchBar(searchText: $searchText)
                    .padding(.top, 0)
                    .padding(.horizontal)
       
                HStack{
                    Button(action: {
                        showOverlaysView = true
                    }) {
                        Text("Highlight Area")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showReportingView = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().fill(Color.blue))
                            
                    }
                }
                .padding(.bottom, 5)
                
                
                VStack(alignment: .leading, spacing: 20) {
    
                    HStack{
                        Text("\(animalCount) recent posts")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .padding([.top], 10)
                            .padding([.bottom], -22)
                            .padding(.leading, 15)
                        
                        Spacer()
                        
                        Button(action: {
                    
                        }) {
                            Text("List All")
                                .foregroundColor(.blue)
                                .padding()
                        }
                        .padding(.trailing, 10)
                        .padding([.bottom], -32)
                        .frame(maxHeight: 0)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { value in
                            HStack(spacing: 10) {
                                ForEach(annotations) { annotation in
                                    if annotation.type == .animal {
                                        SimilarStrayBubble(
                                            imageName: annotation.imageName!,
                                            breed: "Unknown",
                                            colors: "Unknown",
                                            gender: "Unknown",
                                            size: "Unknown",
                                            address: "Unknown",
                                            date: "Unknown"
                                        )
                                        .id(annotation.id)
                                        .onTapGesture {
                                            focusOnAnnotation(withId: annotation.id)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    

                }
                .background(Color.white.opacity(0.8))
                .edgesIgnoringSafeArea(.bottom)
            }

        }
        .onAppear {
            Task {
                await performAutomaticAction()
            }
        }
        .fullScreenCover(item: $selectedAnnotation, content: {
            annotation in AnimalDetailsView(selectedAnnotation: $selectedAnnotation)
        })
        .sheet(isPresented: $showReportingView) {
            ReportingView()
        }
        .fullScreenCover(isPresented: $showOverlaysView) {
            let newCenter = CLLocationCoordinate2D(
                        latitude: region.center.latitude + 0.003,  // Adjust latitude for display
                        longitude: region.center.longitude
            )
            let region_ = MKCoordinateRegion(
                center: newCenter,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            OverlaysView(annotations:annotations, region: region_)
        }
    }
    
    
    func performAutomaticAction() async  {
        annotations = [
            AnimalAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.390873, longitude: 114.198035), title: "San Francisco", subtitle: "Cat Spot", imageName: "image3", type: .animal),
            AnimalAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.394873, longitude: 114.198035), title: "San Francisco", subtitle: "Cat Spot", imageName: "img_bl_content2", type: .animal),
            AnimalAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.393873, longitude: 114.202035), title: "San Francisco", subtitle: "Dog Spot", imageName: "dog", type: .animal),

            CameraAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.396873, longitude: 114.198035), title: "San Francisco", subtitle: "Dog Spot", imageName: "camera", type: .camera),
            CameraAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.392873, longitude: 114.195535), title: "San Francisco", subtitle: "Dog Spot", imageName: "camera", type: .camera),
            CameraAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.388873, longitude: 114.200035), title: "San Francisco", subtitle: "Dog Spot", imageName: "camera", type: .camera),
            CameraAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.386473, longitude: 114.196035), title: "San Francisco", subtitle: "Dog Spot", imageName: "camera", type: .camera)
        ]
        do {
            let animals = try  await performAPICall_Animals()
            for animal in animals {
                annotations.append(AnimalAnnotation(coordinate: CLLocationCoordinate2D(
                                                    latitude: animal.latitude,
                                                    longitude: animal.longitude),
                                                    title: "San Francisco",
                                                    subtitle: "Dog Spot",
                                                    imageName: "dog", type: .animal))
            }
        } catch {}
        do {
            let cameras = try  await performAPICall_Cameras()
            for camera in cameras {
                annotations.append(CameraAnnotation(coordinate: CLLocationCoordinate2D(
                                                    latitude: camera.latitude,
                                                    longitude: camera.longitude),
                                                    title: "San Francisco",
                                                    subtitle: "Dog Spot",
                                                    imageName: "camera", type: .camera))
            }
        } catch {}
    }
    
    
    func focusOnAnnotation(withId id: UUID) {
        guard let annotation = annotations.first(where: { $0.id == id }) else { return }
        let newCenter = CLLocationCoordinate2D(
            latitude: annotation.coordinate.latitude - 0.0028, // Adjust latitude for display
            longitude: annotation.coordinate.longitude
        )
        withAnimation {
            region = MKCoordinateRegion(
                center: newCenter, // True center
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }

}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}







struct SimilarStrayBubble: View {
    var imageName: String
    var breed: String
    var colors: String
    var gender: String
    var size: String
    var address: String
    var date: String
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(breed)
                        .font(.headline)
                    Text(colors)
                        .font(.subheadline)
                    Text(gender)
                        .font(.subheadline)
                    Text(size)
                        .font(.subheadline)
                }
                .padding()
                
                Spacer()
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            }
            
            HStack{
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text(address)
                        .font(.footnote)
                    Spacer()
                }
                .padding([.leading, .bottom, .trailing])
                
                
                HStack {
                    Image(systemName: "calendar")
                    Text(date)
                        .font(.footnote)
                    Spacer()
                }
                .padding([.leading, .bottom, .trailing])
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 5)
    }
}
