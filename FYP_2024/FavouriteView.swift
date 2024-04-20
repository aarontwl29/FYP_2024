import SwiftUI

//Create a Search Bar and Filter For User input stray cats' name and checkbox/radio to do filter, On the top of this page

struct PetCardView: View {
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
        .padding(.horizontal)
    }
}

struct FavouriteView: View {
    @State private var searchText = ""
    @State private var filterMale = true

    var body: some View {
        VStack {
            // Search Bar
            TextField("Search for stray cats", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()


            // List of Pets
            ScrollView {
                VStack {
                    ForEach(0..<10, id: \.self) { _ in
                        PetCardView(
                            imageName: "image1",
                            breed: "Mixed Breed",
                            colors: "Black, White",
                            gender: "Male",
                            size: "Medium (15-25 kg)",
                            address: "Kpousódou 21, Athína 115 28, Elláda",
                            date: "11/04/2024"
                        )
                    }
                }
            }
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
