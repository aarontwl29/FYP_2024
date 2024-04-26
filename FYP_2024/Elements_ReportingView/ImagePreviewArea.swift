import SwiftUI

struct ImagePreviewArea: View {
    @Binding var images: [UIImage]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 8) {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 160)
    }
}


#Preview {
    ImagePreviewArea(images: .constant([UIImage(named: "cat")!,
                                        UIImage(named: "dog")!]))
}
