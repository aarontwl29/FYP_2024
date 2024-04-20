import SwiftUI

struct CatAnnotationView: View {
    var body: some View {
        Image("cat")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30) // Adjust the size as needed
            .clipShape(Circle()) // Makes the image circular
            .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Adds a white border
    }
}

#Preview {
    CatAnnotationView()
}
