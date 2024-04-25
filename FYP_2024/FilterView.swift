import SwiftUI
import MapKit

struct FilterView: View {
    @State private var nickname: String = ""
    @State private var image: UIImage? = nil
    @State private var location: CLLocationCoordinate2D? = nil
    @State private var date: Date = Date()
    @State private var animalType: AnimalType = .dog
    @State private var breed: String = ""
    
    enum AnimalType: String, CaseIterable {
        case dog = "Dog"
        case cat = "Cat"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nickname")) {
                    TextField("Enter nickname", text: $nickname)
                }
                
                Section(header: Text("Photo")) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    } else {
                        Button(action: takePhoto) {
                            Text("Take Photo")
                        }
                    }
                }
                
                
                Section(header: Text("Date and Time")) {
                    DatePicker("Date and Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
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
            }
            .navigationBarTitle("Report Stray Animal")
            .navigationBarItems(trailing: Button(action: submitReport) {
                Text("Submit")
            })
        }
    }
    
    func takePhoto() {
        // Implement functionality to take a photo using the device's camera
    }
    
    func getCurrentLocation() {
        // Implement functionality to get the user's current location
    }
    
    func submitReport() {
        // Implement functionality to submit the report with the entered data
    }
    
    // Replace these with actual breed lists
    let dogBreeds = ["Labrador Retriever", "German Shepherd", "Golden Retriever", "Bulldog", "Beagle"]
    let catBreeds = ["Siamese", "Persian", "Maine Coon", "Bengal", "Ragdoll"]
}

#Preview {
    FilterView()
}
