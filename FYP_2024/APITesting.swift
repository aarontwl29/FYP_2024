import SwiftUI

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
    let url = URL(string: "https://594a-123-203-44-5.ngrok-free.app/animals")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode([Animal].self, from: data)
    
    return wrapper
}

struct TestAPIView: View {
    @State private var animals: [Animal] = []
    @State private var isLoading = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                } else if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List(animals) { animal in
                        VStack(alignment: .leading) {
                            Text("Nickname: \(animal.nickName)")
                            Text("Breed: \(animal.breed)")
                            Text("Health Status: \(animal.healthStatus)")
                            Text("Age: \(animal.age)")
                        }
                    }
                }
            }
            .navigationBarTitle("Test API")
            .toolbar {
                Button("Fetch Animals") {
                    fetchAnimals()
                }
            }
        }
    }

    func fetchAnimals() {
        isLoading = true
        errorMessage = ""

        Task {
            do {
                let fetchedAnimals = try await performAPICall()
                animals = fetchedAnimals
            } catch {
                errorMessage = "Error fetching animals: \(error.localizedDescription)"
            }

            isLoading = false
        }
    }
}

struct TestAPIView_Previews: PreviewProvider {
    static var previews: some View {
        TestAPIView()
    }
}


