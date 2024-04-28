import Foundation

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
