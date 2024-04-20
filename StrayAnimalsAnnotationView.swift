import SwiftUI
import MapKit

class StrayAnimalsAnnotation: NSObject, MKAnnotation, Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class StrayAnimalsAnnotationView: MKAnnotationView {
    static let reuseIdentifier = "StrayAnimalsAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = true
        self.calloutOffset = CGPoint(x: -5, y: 5)
        self.setupAnnotationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAnnotationView() {
        guard let annotation = annotation as? StrayAnimalsAnnotation else { return }
        
        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        circleView.layer.cornerRadius = 20
        circleView.backgroundColor = .systemBlue
        
        let triangleView = UIView(frame: CGRect(x: 10, y: 30, width: 20, height: 10))
        triangleView.backgroundColor = .systemBlue
        triangleView.layer.masksToBounds = true
        triangleView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        let imageView = UIImageView(image: UIImage(named: "cat"))
        imageView.frame = CGRect(x: 5, y: 5, width: 30, height: 30)
        circleView.addSubview(imageView)
        
        circleView.addSubview(triangleView)
        self.addSubview(circleView)
    }
}

