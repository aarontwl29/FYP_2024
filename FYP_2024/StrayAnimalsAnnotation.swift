import SwiftUI
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let image: UIImage?
    let title: String?
    let subtitle: String?

    init(coordinate: CLLocationCoordinate2D, image: UIImage? = nil, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
}

class StrayAnimalsAnnotationView: MKAnnotationView {
    static let reuseIdentifier = "CustomAnnotationView"

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
        guard let annotation = annotation as? CustomAnnotation else { return }

        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        circleView.layer.cornerRadius = 20
        circleView.backgroundColor = .systemBlue

        let triangleView = UIView(frame: CGRect(x: 10, y: 30, width: 20, height: 10))
        triangleView.backgroundColor = .systemBlue
        triangleView.layer.masksToBounds = true
        triangleView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)

        if let image = annotation.image {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 5, y: 5, width: 30, height: 30)
            circleView.addSubview(imageView)
        }

        circleView.addSubview(triangleView)
        self.addSubview(circleView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        // Handle tap gesture here
        // You can navigate to a new page or show a pop-up
        print("Annotation tapped")
    }
}

#Preview {
    StrayAnimalsAnnotation()
}
