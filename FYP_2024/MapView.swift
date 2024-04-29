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
    @State private var showListAllView = false
        

    @State private var annotations: [CustomAnnotation] = []
    @State private var addresses: [UUID: String] = [:]
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
                            if let animalAnnotation = location as? AnimalAnnotation {
                                // This is an animal annotation, access animal-specific properties
                                if let urlString = animalAnnotation.animal.image, let url = URL(string: urlString) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image.resizable() // Display the loaded image.
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                        case .failure(_):
                                            Color.red // Indicates an error.
                                        case .empty:
                                            ProgressView() // Display a progress view while loading.
                                        @unknown default:
                                            EmptyView() // Handle unexpected cases.
                                        }
                                    }
                                }
                            }
                            else if let cameraAnnotation = location as? CameraAnnotation {
                                // This is a camera annotation, access camera-specific properties
                                if let imageName = cameraAnnotation.imageName {
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .clipShape(Circle())
                                }
                            } else {
                                // Default view if the annotation type is unknown
                                Color.gray.frame(width: 30, height: 30).clipShape(Circle())
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
                            showListAllView.toggle()
                    
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
                                    if let animalAnnotation = annotation as? AnimalAnnotation, annotation.type == .animal {
                                        SimilarStrayBubble(
                                            uiImage: animalAnnotation.uiImage,
                                            breed: animalAnnotation.animal.nickName,
                                            colors: animalAnnotation.animal.color,
                                            gender: animalAnnotation.animal.gender,
                                            size: "\(animalAnnotation.animal.age) years",
                                            address: addresses[annotation.id] ?? "Unknown",
                                            date: randomDateWithinLastWeek()
                                        )
                                        .id(annotation.id)
                                        .onAppear {
                                            // Perform reverse geocoding when the bubble appears
                                            let location = CLLocation(latitude: animalAnnotation.animal.latitude, longitude: animalAnnotation.animal.longitude)
                                            getPlacemark(forLocation: location) { placemark in
                                                if let placemark = placemark {
                                                    let address = getAddressString(from: placemark)
                                                    addresses[annotation.id] = address
                                                } else {
                                                    addresses[annotation.id] = "Unknown"
                                                }
                                            }
                                        }
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
            annotation in AnimalDetailsView(isLiked: false, selectedAnnotation: $selectedAnnotation)
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
        .sheet(isPresented: $showListAllView) {
            ListAllView(annotations: annotations)
        }
    }
    
    
    func performAutomaticAction() async  {
        annotations = []
        do {
            let animals = try await performAPICall_Animals()
            for animal in animals {
                let annotation = AnimalAnnotation(
                    coordinate: CLLocationCoordinate2D(latitude: animal.latitude, longitude: animal.longitude),
                    title: "Stray Animal",
                    subtitle: animal.nickName,
                    imageName: "", // Assuming you handle image separately
                    type: .animal,
                    animal: animal
                )

                let hardcodedImageUrl = animal.image
                if let urlString = animal.image, let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        annotation.uiImage = image
                    }
                }
                
                
                if let album = animal.album {
                    for urlString in album {
                        if let url = URL(string: urlString) {
                            do {
                                let (data, _) = try await URLSession.shared.data(from: url)
                                if let image = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        annotation.uiImages.append(image)
                                    }
                                }
                            } catch {
                                print("Failed to load image from URL: \(urlString)")
                            }
                        }
                    }
                }
        
                if(annotation.uiImage != nil){
                    print("UIImage: " , annotation.uiImage)
                }else{
                    print("nil!")
                }
                annotations.append(annotation)
            }
        } catch {}
        do {
            let cameras = try  await performAPICall_Cameras()
            for camera in cameras {
                annotations.append(CameraAnnotation(coordinate: CLLocationCoordinate2D(
                                                    latitude: camera.latitude,
                                                    longitude: camera.longitude),
                                                    title: "Camera",
                                                    subtitle: camera.cameraId,
                                                    imageName: "camera",
                                                    type: .camera,
                                                    camera: camera))
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

    func randomDateWithinLastWeek() -> String {
        let today = Date()
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: today)!
        
        let randomTimeInterval = TimeInterval.random(in: (oneWeekAgo.timeIntervalSince1970)...(today.timeIntervalSince1970))
        let randomDate = Date(timeIntervalSince1970: randomTimeInterval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM" // Custom format: day and full month name
        return dateFormatter.string(from: randomDate)
    }
    
    func getPlacemark(forLocation location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(placemarks?.first)
        }
    }

    func getAddressString(from placemark: CLPlacemark) -> String {
        var addressString = ""
        if let street = placemark.thoroughfare {
            addressString += street + ", "
        }
        if let city = placemark.locality {
            addressString += city
        }
        return addressString
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}







struct SimilarStrayBubble: View {
    var uiImage: UIImage?
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
                
                if let uiImage = uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 100, height: 100)
                }
                
                
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
