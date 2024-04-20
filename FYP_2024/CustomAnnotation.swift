import MapKit

class CustomAnnotation: NSObject, MKAnnotation, Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let imageName: String?

    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil, imageName: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
    }
}

class CustomAnnotationView: MKAnnotationView {
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

        if let imageName = annotation.imageName, let image = UIImage(named: imageName) {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 5, y: 5, width: 30, height: 30)
            circleView.addSubview(imageView)
        }

        self.addSubview(circleView)
    }
}
