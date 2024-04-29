import Foundation
import UIKit

struct Report: Codable {
    var image: String
//    var reportId: String
    var gender: String
    var color: String
    var nickName: String
    var album: [String]
    var latitude: Double
    var description: String
    var video: String?
    var type: String
    var userId: String
    var breed: String
    var neuteredStatus: String
    var healthStatus: String
    var voiceSample: String?
    var age: Int
    var longitude: Double
    var timestamp: Int64
}

struct Report_GET: Decodable {
    let image: String?
    let reportId: String
    let gender: String
    let color: String
    let nickName: String
    let album: [String]?
    let latitude: Double
    let description: String
    let video: String
    let type: String
    let userId: String
    let breed: String
    let neuteredStatus: String
    let healthStatus: String
    let voiceSample: String
    let age: Int
    let longitude: Double
    let timestamp: Int64
}

struct Report_UIImage: Identifiable {
    let id: UUID = UUID() // Add an id property if Report_GET doesn't have a unique identifier
    let report: Report_GET
    var uiImage: UIImage?
    var uiImages: [UIImage] = []
}


func performAPICall_Reports() async throws -> [Report_GET] {
    let url = URL(string: "https://fyp2024.azurewebsites.net/reports/user/user123")!
    let (data, _) = try await URLSession.shared.data(from: url)
    print("report in")
    let wrapper = try JSONDecoder().decode([Report_GET].self, from: data)
    print("report out")
    return wrapper
}
