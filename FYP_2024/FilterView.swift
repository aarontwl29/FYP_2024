import SwiftUI

struct ImageViewer: View {
    var images: [String]

    var body: some View {
        TabView {
            ForEach(images, id: \.self) { img in
                Image(img)
                    .resizable()
                    .scaledToFit()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 300)
    }
}

struct InfoCell: View {
    var label: String
    var value: String
    var backgroundColor: Color = .green // Default background color

    var body: some View {
        VStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title2)
        }
        .padding() // Add padding around the text
        .background(backgroundColor) // Set the background color
        .cornerRadius(8) // Optional: Add a corner radius for a rounded rectangle look
    }
}

struct AnimalInfoGrid: View {
    @State private var selectedAnnotation: CustomAnnotation?
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            InfoCell(label: "Name", value: "")
            InfoCell(label: "Age", value: "")
            InfoCell(label: "Gender", value: "123")
            InfoCell(label: "Species", value: "")
        }
        .padding()
    }
}

struct LinksView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Link("Adopt this animal", destination: URL(string: "https://adopt.com")!)
            Link("More about animal care", destination: URL(string: "https://care.com")!)
        }
        .padding()
    }
}

struct DetailsTable: View {

    var body: some View {
        VStack {
            HStack {
                Text("Camera")
                Spacer()
                Text("location")
                Spacer()
                Text("TimeStamp")
                Spacer()
                Text("Date")
                Spacer()
            }
            .font(.headline)
            .padding()

            HStack {
                Text("data")
                Spacer()
                Text("data")
                Spacer()
                Text("data")
                Spacer()
                Text("data")
                Spacer()
            }
            .padding()
        }
    }
}

struct FilterView: View {
    var body: some View {
        ScrollView {
                    VStack {
                        ImageViewer(images: ["cat", "dog"])
                        AnimalInfoGrid()
                        LinksView()
                        DetailsTable()
                    }
                }
    }
}

#Preview {
    FilterView()
}
