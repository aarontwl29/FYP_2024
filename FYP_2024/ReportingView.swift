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
                    Button(action: getCurrentLocation) {
                        Text("Get Current Location")
                    }

                    Button(action: selectLocationFromMap) {
                        Text("Select Location from Map")
                    }
                }
                
                Section(header: Text("Nickname")) {
                    TextField("Enter nickname", text: $nickname)
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
