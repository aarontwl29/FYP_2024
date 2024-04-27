import MapKit

enum AnnotationType {
    case camera
    case animal
}

class CustomAnnotation: NSObject, MKAnnotation, Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let imageName: String?
    let type: AnnotationType

    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil, imageName: String? = nil, type: AnnotationType) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.type = type
        super.init()
    }
}
class AnimalAnnotation: CustomAnnotation {
    

    override init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, imageName: String?, type: AnnotationType) {
        super.init(coordinate: coordinate, title: title, subtitle: subtitle, imageName: imageName, type: type)
    }
}
class CameraAnnotation: CustomAnnotation {
    

    override init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, imageName: String?, type: AnnotationType) {
        super.init(coordinate: coordinate, title: title, subtitle: subtitle, imageName: imageName, type: type)
    }
}

struct Animal: Codable, Identifiable {
    let animalId: String
    let image: String
    let gender: String
    let color: String
    let nickName: String
    let latitude: Double
    let longitude: Double
    let description: String
    let type: String
    let breed: String
    let neuteredStatus: String
    let healthStatus: String
    let age: Int
    let album: [String]
    let video: String?
    let voiceSample: String?
    
    var id: String {
        return animalId
    }
}

struct Camera: Codable, Identifiable {
    let cameraId: String
    let ip: String
    let latitude: Double
    let longitude: Double
    let startTime: Int64
    let url: String
    
    var id: String {
        return cameraId
    }
}


func performAPICall_Animals() async throws -> [Animal] {
    let url = URL(string: "https://fyp2024.azurewebsites.net/animals")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode([Animal].self, from: data)
    return wrapper
}
func performAPICall_Cameras() async throws -> [Camera] {
    let url = URL(string: "https://fyp2024.azurewebsites.net/cameras")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode([Camera].self, from: data)
    return wrapper
}
