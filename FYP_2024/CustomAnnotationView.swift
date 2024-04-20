import MapKit

protocol CustomAnnotationViewDelegate: AnyObject {
    func annotationView(_ view: CustomAnnotationView, didTapAnnotationType type: AnnotationType?)
}

class CustomAnnotationView: MKAnnotationView {
    static let reuseIdentifier = "CustomAnnotationView"
    
    weak var delegate: CustomAnnotationViewDelegate?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = true
        self.canShowCallout = true
        self.calloutOffset = CGPoint(x: -5, y: 5)
        self.setupAnnotationView()
        self.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
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
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        print("Annotation tapped")
        if gestureRecognizer.state == .ended {
            if let annotation = annotation as? CustomAnnotation {
                print("Delegate about to be called, type: \(annotation.type)")
                delegate?.annotationView(self, didTapAnnotationType: annotation.type)
            }
        }
    }
}
