import SwiftUI



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


