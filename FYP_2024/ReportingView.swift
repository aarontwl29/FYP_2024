import SwiftUI
import MapKit
import UIKit


struct ReportingView: View {
    
    @State private var voiceFileURL: URL?
    
    
    
    
    @State private var nickname: String = ""
    @State private var images: [UIImage] = [
        UIImage(named: "cat")!,
        UIImage(named: "dog")!
    ]
    @State private var capturedImage: UIImage?
    @State private var location: CLLocationCoordinate2D? = nil
    @State private var date: Date = Date()
    @State private var animalType: AnimalType = .dog
    @State private var breed: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var selectedColor: Color = .red
    
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showFilePickerView = false
    
    
    enum AnimalType: String, CaseIterable {
        case dog = "Dog"
        case cat = "Cat"
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Photos")) {
                                    ImagePreviewArea(images: $images)
                                    
                    Button(action: takePhoto) {
                        Text("Take Photo")
                    }
                                    
                                    Button(action: {
                                        showImagePicker = true
                                    }) {
                                        Text("Import Photos")
                                    }
                                }
                
                Section(header: Text("Color")) {
                    HStack {
                        ForEach(colors, id: \.self) { color in
                            ColorSampleView(color: color, selectedColor: $selectedColor)
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
                
                Section(header: Text("Date and Time")) {
                    DatePicker("Date and Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
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
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(image: $selectedImage, onDismiss: { image in
                                if let image = image {
                                    images.append(image)
                                }
                            })
                        }
                        .sheet(isPresented: $showFilePickerView) {
                            VoiceFileUploadView(voiceFileURL: $voiceFileURL, onDismiss: {
                                // Perform any necessary actions when the view is dismissed
                            })
                        }

        }
    }
    
    func loadImage(_ image: UIImage?) {
            if let image = image {
                images.append(image)
            }
        }
        
    func loadImages(_ newImages: [UIImage]) {
            images.append(contentsOf: newImages)
    }
    
    func takePhoto() {
   
    }
    
    
    func submitReport() {
        // Implement functionality to submit the report with the entered data
    }
    
    // Replace these with actual breed lists
    let dogBreeds = ["Labrador Retriever", "German Shepherd", "Golden Retriever", "Bulldog", "Beagle"]
    let catBreeds = ["Siamese", "Persian", "Maine Coon", "Bengal", "Ragdoll"]
    
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .brown, .gray, .black]
}

struct ImagePreviewArea: View {
    @Binding var images: [UIImage]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 8) {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 180)
    }
}

struct ColorSampleView: View {
    let color: Color
    @Binding var selectedColor: Color
    
    var body: some View {
        Button(action: {
            selectedColor = color
        }) {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 40, height: 40)
                
                if selectedColor == color {
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 44, height: 44)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 4)
        .accessibilityLabel(color.description)
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
        @Environment(\.presentationMode) private var presentationMode
        var onDismiss: (UIImage?) -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
                imagePicker.delegate = context.coordinator
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // No need to implement this method
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}





#Preview {
    ReportingView()
}
