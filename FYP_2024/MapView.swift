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
                            region = MKCoordinateRegion(
                                center: self.selectedAnnotation!.coordinate,
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
                Spacer()
                
                Button(action: {
                    showOverlaysView = true
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
                
                
                VStack(alignment: .leading, spacing: 20) {
 
                    Text("Similar Stray Animals")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                        .padding([.top], 10)
                        .padding([.bottom], -15)
                        .padding(.leading, 15)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(annotations) { annotation in
                                if annotation.type == .animal {
                                    SimilarStrayBubble(
                                        imageName: annotation.imageName!,
                                        breed: "N/A",
                                        colors: "N/A",
                                        gender: "N/A",
                                        size: "N/A",
                                        address: "N/A",
                                        date: "N/A"
                                    )
                                }
                            }
                        }
                        .padding()
                    }
                    

                }
                .background(Color(.white))
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
            OverlaysView(annotations:annotations, region: region)
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
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}











