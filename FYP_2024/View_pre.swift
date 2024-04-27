

import SwiftUI

struct View_pre: View {
    var imageName: String
    var breed: String
    var colors: String
    var gender: String
    var size: String
    var address: String
    var date: String
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(breed)
                        .font(.headline)
                    Text(colors)
                        .font(.subheadline)
                    Text(gender)
                        .font(.subheadline)
                    Text(size)
                        .font(.subheadline)
                }
                .padding()
                
                Spacer()
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            }
            
            HStack {
                Image(systemName: "mappin.and.ellipse")
                Text(address)
                    .font(.footnote)
                Spacer()
            }
            .padding([.leading, .bottom, .trailing])
            
            HStack {
                Image(systemName: "calendar")
                Text(date)
                    .font(.footnote)
                Spacer()
            }
            .padding([.leading, .bottom, .trailing])
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 5)
    }
}

#Preview {
    View_pre(
        imageName: "dog",
        breed: "N/A",
        colors: "N/A",
        gender: "N/A",
        size: "N/A",
        address: "N/A",
        date: "N/A"
    )
}
