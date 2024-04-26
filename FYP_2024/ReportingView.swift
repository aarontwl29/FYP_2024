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
    
    @State private var lastSeenDate: Date = Date()
    @State private var appearTime: Date = Date()
    @State private var disappearTime: Date = Date()

    
    @State private var nickname: String = ""
    @State private var location: CLLocationCoordinate2D? = nil
    @State private var animalType: AnimalType = .dog
    @State private var breed: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    
    @State private var selectedGender: String? = "Male"
    @State private var selectedNeuteredStatus: String? = "Yes"
    @State private var selectedHealthStatus: String? = "Healthy"
    
    enum AnimalType: String, CaseIterable {
        case dog = "Dog"
        case cat = "Cat"
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Photos")) {
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
                        Picker("Dog Breed", selection: $breed) {
                            ForEach(dogBreeds, id: \.self) { breed in
                                Text(breed)
                            }
                        }
                    } else {
                        Picker("Cat Breed", selection: $breed) {
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

                Section(header: Text("Location")) {
                    switch locationViewModel.authorizationStatus {
                    case .authorizedWhenInUse, .authorizedAlways:
                        // Display location-related UI
                        Button(action: getCurrentLocation) {
                            Text("Get Current Location")
                        }

                        Button(action: selectLocationFromMap) {
                            Text("Select Location from Map")
                        }
                        
                        if let selectedLocation = locationViewModel.selectedLocation {
                            Text("Selected Location: \(selectedLocation.latitude), \(selectedLocation.longitude)")
                        } else {
                            Text("No location selected")
                        }
                    case .denied, .restricted:
                        Text("Location access denied. Please grant permission in Settings.")
                    case .notDetermined:
                        Text("Location access not determined. Please allow access to use location features.")
                    default:
                        Text("Unable to determine location access status.")
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
                    
                    
                    
                    Section(header: Text("Gender")) {
                                HStack {
                                    RadioButtonField(
                                        id: "Male",
                                        label: "Male",
                                        selectedValue: $selectedGender
                                    )

                                    RadioButtonField(
                                        id: "Female",
                                        label: "Female",
                                        selectedValue: $selectedGender
                                    )
                                }
                            }

                            Section(header: Text("Neutered Status")) {
                                HStack {
                                    RadioButtonField(
                                        id: "Yes",
                                        label: "Yes",
                                        selectedValue: $selectedNeuteredStatus
                                    )

                                    RadioButtonField(
                                        id: "No",
                                        label: "No",
                                        selectedValue: $selectedNeuteredStatus
                                    )

                                    RadioButtonField(
                                        id: "Unknown",
                                        label: "Unknown",
                                        selectedValue: $selectedNeuteredStatus
                                    )
                                }
                            }

                            Section(header: Text("Health Status")) {
                                HStack {
                                    RadioButtonField(
                                        id: "Healthy",
                                        label: "Healthy",
                                        selectedValue: $selectedHealthStatus
                                    )

                                    RadioButtonField(
                                        id: "Sick",
                                        label: "Sick",
                                        selectedValue: $selectedHealthStatus
                                    )

                                    RadioButtonField(
                                        id: "Injured",
                                        label: "Injured",
                                        selectedValue: $selectedHealthStatus
                                    )
                                }
                            }
                     
                        
                    
                    
                    Section(header: Text("Voice Sample")) {
                        VoiceFilePickerView(voiceFileURL: $voiceFileURL)
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
                            Text("Submit")
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

        }
    }
    
    func getCurrentLocation() {
        locationViewModel.getCurrentLocation()
    }
    
    func selectLocationFromMap() {
        locationViewModel.selectLocationFromMap()
    }
    
    func submitReport() {
        // Implement functionality to submit the report with the entered data
    }
}


#Preview {
    ReportingView()
}



struct RadioButtonField<T: Hashable>: View {
    let id: T
    let label: String
    @Binding var selectedValue: T?
    
    var body: some View {
        Button(action: {
            selectedValue = id
        }) {
            HStack {
                Image(systemName: selectedValue == id ? "circle.fill" : "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                
                Text(label)
            }
        }
        .foregroundColor(Color.primary)
    }
}
