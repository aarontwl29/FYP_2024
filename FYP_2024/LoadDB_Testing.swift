import SwiftUI
import Combine

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
    let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
    
    return wrapper.items
}
