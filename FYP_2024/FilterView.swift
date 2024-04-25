import SwiftUI

struct FilterView: View {
    var body: some View {
        ScrollView {
                    VStack {
                        
                        Text("Filter View")
                        ImageViewer(images: ["cat", "dog"])
                    }
                }
   
    }
}

#Preview {
    FilterView()
}
