
import SwiftUI
import CoreLocation

struct ListAllView: View {
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    @State private var showingDetails = false  // 用於控制是否顯示詳細信息視圖
    
    var annotations: [CustomAnnotation]
    var animalAnnotations: [CustomAnnotation] {
        annotations.filter { annotation in annotation.type == .animal}
    }
    @State private var addresses: [UUID: String] = [:]
    @State private var selectedAnnotation: CustomAnnotation?
    

    var body: some View {
        VStack {
            TextField("Search for stray cats", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
            
            Button(action: {
                self.isFilterViewPresented = true
            }) {
                Label("Filter", systemImage: "slider.horizontal.3")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            .sheet(isPresented: $isFilterViewPresented) {
                FilterView()
            }
            
            ScrollView {
                VStack(spacing: 15) {
                    //實現更改，更改Loop的內容，裡面內容改為PetCardView的array
                    //                    ForEach(petCardViews, id: \.nickName) { petCardView in
                    //                        petCardView
                    //                            .onTapGesture {
                    //                                self.showingDetails = true
                    //                            }
                    //                            .sheet(isPresented: $showingDetails) {
                    //                                // 顯示詳細信息視圖
                    //                                AnimalDetailsView(isLiked: false, selectedAnnotation: .constant(nil)).padding(.top,20)
                    //                            }
                    //                    }
                    
                    ForEach(annotations, id: \.id) { annotation in
                        if let animalAnnotation = annotation as? AnimalAnnotation, annotation.type == .animal {
                            PetCardView(
                                uiImage: animalAnnotation.uiImage,
                                nickName: animalAnnotation.animal.nickName,
                                breed: animalAnnotation.animal.breed,
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
                                self.selectedAnnotation = annotation
                            }
                        }
                    }
                    
                    
                }.padding(.top, 10)
            }
            .padding(.top, -10)
        }.padding(.top, 20)
            .fullScreenCover(item: $selectedAnnotation, content: {
                annotation in AnimalDetailsView(isLiked: false, selectedAnnotation: $selectedAnnotation)
            })
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
    
    struct PetCardView: View {
        var uiImage: UIImage?
        var nickName: String
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
                        Text(nickName)
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.blue)
                            .padding(.bottom,4)
                        Text(breed)
                            .font(.subheadline)
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
                    }
                }
                
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
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
        }
    }
    
    
    
    
    
    //    let petCardViews: [PetCardView] = [
    //        PetCardView(
    //            imageName: "image1",
    //            nickName: "Buddy",
    //            breed: "Labrador",
    //            colors: "Yellow",
    //            gender: "Male",
    //            size: "Large",
    //            address: "123 Pet St, New York",
    //            date: "20/04/2024"
    //        ),
    //        PetCardView(
    //            imageName: "image2",
    //            nickName: "Whiskers",
    //            breed: "Siamese",
    //            colors: "Brown, Black",
    //            gender: "Female",
    //            size: "Small",
    //            address: "234 Cat Ave, Boston",
    //            date: "21/04/2024"
    //        ),
    //        PetCardView(
    //            imageName: "image3",
    //            nickName: "Fluffy",
    //            breed: "Rabbit",
    //            colors: "White",
    //            gender: "Male",
    //            size: "Small",
    //            address: "345 Bunny Blvd, Chicago",
    //            date: "22/04/2024"
    //        ),
    //        PetCardView(
    //            imageName: "image1",
    //            nickName: "Buddy",
    //            breed: "Labrador",
    //            colors: "Yellow",
    //            gender: "Male",
    //            size: "Large",
    //            address: "123 Pet St, New York",
    //            date: "20/04/2024"
    //        ),
    //        PetCardView(
    //            imageName: "image2",
    //            nickName: "Whiskers",
    //            breed: "Siamese",
    //            colors: "Brown, Black",
    //            gender: "Female",
    //            size: "Small",
    //            address: "234 Cat Ave, Boston",
    //            date: "21/04/2024"
    //        ),
    //        PetCardView(
    //            imageName: "image3",
    //            nickName: "Fluffy",
    //            breed: "Rabbit",
    //            colors: "White",
    //            gender: "Male",
    //            size: "Small",
    //            address: "345 Bunny Blvd, Chicago",
    //            date: "22/04/2024"
    //        )]
}


//#Preview {
//    ListAllView()
//}
