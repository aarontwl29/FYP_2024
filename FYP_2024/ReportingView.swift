import SwiftUI
import MapKit
import UIKit
import CoreLocation

struct ReportingView: View {
    
    
    
    @State private var capturedImage: UIImage?
    //    @State private var selectedImage: UIImage?
    @State private var images: [UIImage] = [
        UIImage(named: "cat")!,
        UIImage(named: "dog")!
    ]
    @State private var voiceFileURL: URL?
    
    @StateObject private var locationViewModel = LocationViewModel()
    @State private var showSubmitSimilarPage = false
    
    
    
    @State private var showCameraView = false
    @State private var showPhotoImportView = false
    @State private var showFilePickerView = false
    
    @State private var showLocationPicker = false
    
    @State private var showAdditionalDetails = false
    
    // Replace these with actual breed lists
    let dogBreeds = ["Labrador Retriever", "German Shepherd", "Golden Retriever", "Bulldog", "Beagle"]
    let catBreeds = ["Siamese", "Persian", "Maine Coon", "Bengal", "Ragdoll"]
    
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .brown, .gray, .black]
    
    
    // Data return
    @State private var selectedColors: [Color] = []
    @State private var animalType: AnimalType = .dog
    @State private var breed: String = ""
    @State private var lastSeenDate: Date = Date()
    @State private var appearTime: Date = Date()
    @State private var disappearTime: Date = Date()
    @State private var location: CLLocationCoordinate2D? = nil
    
    @State private var nickname: String = ""
    @State private var ageInput: String = ""
    @State private var selectedGender: String?
    @State private var selectedNeuteredStatus: String?
    @State private var selectedHealthStatus: String?
    @State private var animalDescription: String = ""
    
    @State private var locationInput: String = ""
    @State private var showAdditionalDetail: Bool = false
    
    
    
    @State private var email: String = ""
    @State private var phone: String = ""
    
    
    enum AnimalType: String, CaseIterable {
        case dog = "Dog"
        case cat = "Cat"
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Photos")) {
                    //1.新增每張圖片的右上角新增獨立的delete按鈕
                    ImagePreviewArea(images: $images)
                    
                    Button(action: {
                        showCameraView = true
                    }) {
                        Text("Take Photo")
                    }
                    
                    Button(action: {
                        showPhotoImportView = true
                    }) {
                        Text("Import Photos")
                    }
                }
                
                Section(header: Text("Color")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(ColorOptions.options) { colorOption in
                                ColorOptionView(colorOption: colorOption, selectedColors: $selectedColors)
                            }
                        }
                    }
                }
                
                Section(header: Text("Animal Type")) {
                    Picker("Animal Type", selection: $animalType) {
                        ForEach(AnimalType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    
                    if animalType == .dog {
                        Picker("Species", selection: $breed) {
                            ForEach(dogBreeds, id: \.self) { breed in
                                Text(breed)
                            }
                        }
                    } else {
                        Picker("Species", selection: $breed) {
                            ForEach(catBreeds, id: \.self) { breed in
                                Text(breed)
                            }
                        }
                    }
                }
                
                Section(header: Text("Last Seen Information")) {
                    DatePicker("Date", selection: $lastSeenDate, displayedComponents: .date)
                    DatePicker("Appear Time", selection: $appearTime, displayedComponents: [.hourAndMinute])
                    DatePicker("Disappear Time", selection: $disappearTime, displayedComponents: [.hourAndMinute])
                }
                
                //                Section(header: Text("Location")) {
                //                    switch locationViewModel.authorizationStatus {
                //                    case .authorizedWhenInUse, .authorizedAlways:
                //                        // Display location-related UI
                //                        Button(action: getCurrentLocation) {
                //                            Text("Get Current Location")
                //                        }
                //
                //                        Button(action: selectLocationFromMap) {
                //                            Text("Select Location from Map")
                //                        }
                //
                //                        if let selectedLocation = locationViewModel.selectedLocation {
                //                            Text("Selected Location: \(selectedLocation.latitude), \(selectedLocation.longitude)")
                //                        } else {
                //                            Text("No location selected")
                //                        }
                //                    case .denied, .restricted:
                //                        Text("Location access denied. Please grant permission in Settings.")
                //                    case .notDetermined:
                //                        Text("Location access not determined. Please allow access to use location features.")
                //                    default:
                //                        Text("Unable to determine location access status.")
                //                    }
                //                }
                
                
                
                Section(header: Text("Location")) {
                    TextField("Location", text: $locationInput)
                    Button(action: {
                        locationInput = "21 Yuen Wo Road, Sha Tin"  // 現在這個修改是安全的，因為 locationInput 是一個 @State 變量
                    }) {
                        Text("Auto Fill")
                    }
                }
                
                
                
                Section {
                    Button(action: {
                        showAdditionalDetails.toggle()
                    }) {
                        Text(showAdditionalDetails ? "Hide Additional Details" : "Show Additional Details")
                    }
                }
                
                if showAdditionalDetails {
                    
                    Section(header: Text("Nickname")) {
                        TextField("Enter nickname", text: $nickname)
                    }
                    
                    Section(header: Text("Age")) {
                        TextField("Enter Age", text: $ageInput)
                            .keyboardType(.numberPad)
                    }
                    
                    Section(header: Text("Gender")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                RadioButtonField(id: "male", label: "Male", selectedValue: $selectedGender)
                                RadioButtonField(id: "female", label: "Female", selectedValue: $selectedGender)
                            }
                        }
                    }
                    Section(header: Text("Neutered Status")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                RadioButtonField(id: "yes", label: "True", selectedValue: $selectedNeuteredStatus)
                                RadioButtonField(id: "no", label: "False", selectedValue: $selectedNeuteredStatus)
                            }
                        }
                    }
                    Section(header: Text("Health Status")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                RadioButtonField(id: "healthy", label: "Healthy", selectedValue: $selectedHealthStatus)
                                RadioButtonField(id: "sick", label: "Sick", selectedValue: $selectedHealthStatus)
                                RadioButtonField(id: "injured", label: "Injured", selectedValue: $selectedHealthStatus)
                            }
                        }
                    }
                    
                    Section(header: Text("Voice Sample")) {
                        VoiceFilePickerView(voiceFileURL: $voiceFileURL)
                    }
                    
                    Section(header: Text("Description")) {
                        TextField("Description", text: $animalDescription)
                    }
                    
                    Section(header: Text("Contact Information")) {
                        TextField("Enter email", text: $email)
                            .keyboardType(.emailAddress)
                        TextField("Enter phone number", text: $phone)
                            .keyboardType(.phonePad)
                    }
                }
            }
            .navigationBarTitle("Report Stray Animal")
            .navigationBarItems(trailing: Button(action: submitReport) {
                Text("Next")
            })
            .sheet(isPresented: $showCameraView) {
                CameraView(capturedImage: $capturedImage)
            }
            .sheet(isPresented: $showPhotoImportView) {
                PhotoImportView(selectedImages: $images)
            }
            .sheet(isPresented: $showFilePickerView) {
                VoiceFileUploadView(voiceFileURL: $voiceFileURL, onDismiss: {
                    // Perform any necessary actions when the view is dismissed
                })
            }
            .sheet(isPresented: $locationViewModel.showLocationPicker) {
                LocationPickerView(locationViewModel: locationViewModel)
                    .onChange(of: locationViewModel.locationUpdated) { _ in
                        locationViewModel.locationUpdated = false
                    }
            }
            
        }.sheet(isPresented: $showSubmitSimilarPage) {
            SubmitSimilarPage(isLiked: false, selectedAnnotation: .constant(nil))// Present PaymentView as a modal sheet
        }
    }
    
    func getCurrentLocation() {
        locationViewModel.getCurrentLocation()
    }
    func selectLocationFromMap() {
        locationViewModel.selectLocationFromMap()
    }
    
    func submitReport() {
        showSubmitSimilarPage.toggle()
        
        let age = Int(ageInput) ?? 0
        
        let report = Report(
            image: "https://loremflickr.com/640/480?lock=5085374330175488", // You need to upload the image and get the URL
            
            gender: selectedGender ?? "",
            color: selectedColors.map { $0.description }.joined(separator: ", "),
            nickName: nickname,
            album: ["https://loremflickr.com/640/480?lock=5085374330175488",
                    "https://loremflickr.com/640/480?lock=5085374330175488"], // You need to upload the images and get their URLs
            latitude: location?.latitude ?? 22.390873338752847,
            description: animalDescription, // Add a text field in ReportingView for the description
            video: "", // If you have a video, provide its URL
            type: animalType.rawValue,
            userId: "user123",
            breed: breed,
            neuteredStatus: selectedNeuteredStatus ?? "",
            healthStatus: selectedHealthStatus ?? "",
            voiceSample: voiceFileURL?.absoluteString ?? "",
            age: age, // Add a field in ReportingView for the age
            longitude: location?.longitude ?? 114.19803500942166,
            timestamp: Int64(Date().timeIntervalSince1970 * 1000) // Current timestamp in millisecondsreprot
        )
        
        guard let url = URL(string: "https://fyp2024.azurewebsites.net/reports")
        else {
            print("Invalid URL")
            return
        }
        
        do {
            let jsonData = try JSONEncoder().encode(report)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error submitting report: \(error.localizedDescription)")
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("Report submitted successfully")
                } else {
                    print("Failed to submit report")
                }
            }.resume()
            print(jsonData)
        } catch {
            print("Error encoding report data: \(error.localizedDescription)")
        }
        
    }
    
    
    
    struct ImagePreviewArea: View {
        @Binding var images: [UIImage]
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(images.indices, id: \.self) { index in
                        imageWithDeleteButton(for: images[index], at: index)
                    }
                }
            }
        }
        
        @ViewBuilder
        private func imageWithDeleteButton(for image: UIImage, at index: Int) -> some View {
            ZStack(alignment: .topTrailing) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                
                Button(action: {
                    // Remove image from array
                    images.remove(at: index)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .padding(2)
                        .background(Color.white.opacity(0.6))
                        .clipShape(Circle())
                }
                .padding([.top, .trailing], 5)
            }
            
            
            
            
        }
        
        //        let report = Report(
        //            image: "https://loremflickr.com/640/480?lock=2874928630071296",
        //
        //            gender: "female",
        //            color: "orange",
        //            nickName: "GGWP000",
        //            album: [
        //                "https://picsum.photos/seed/vW73n/640/480",
        //                "https://loremflickr.com/640/480?lock=4153357180600320",
        //                "https://picsum.photos/seed/i5vegAE4sC/640/480"
        //            ],
        //            latitude: 22.4494,
        //            description: "Quo denuncio conor nemo conturbo peior.",
        //            video: "",
        //            type: "cat",
        //            userId: "6dLcsHbjWDGNzWM5yq0c",
        //            breed: "Maremmano-Abruzzese Sheepdog",
        //            neuteredStatus: "yes",
        //            healthStatus: "injured",
        //            voiceSample: "",
        //            age: 99,
        //            longitude: 114.1699,
        //            timestamp: 1714114423784
        //        )
        
    }
    
    
}


#Preview {
    ReportingView()
}


