import SwiftUI

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

import SwiftUI

struct FavouriteView: View {
    @State private var searchText = ""
    @State private var filterMale = true
    @State private var selectedSort = "Date" // 用于排序的选择

    let sortOptions = ["Date", "Name", "Breed"] // 排序选项

    var body: some View {
        VStack {
            // Search Bar
            TextField("Search for stray cats", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)

            // Filter and Sort Button
            // Filter and Sort Button
            HStack {
                Menu {
                    // Toggle for Male/Female filter
                    Toggle("Male Cats Only", isOn: $filterMale)

                    // Picker for sorting options
                    Picker("Sort by", selection: $selectedSort) {
                        ForEach(sortOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                } label: {
                    Label("Filter", systemImage: "slider.horizontal.3")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading) // Label填满宽度，内容靠左
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                // 删除 Spacer
            }
            .padding(.horizontal)
            .padding(.bottom, 10)


            // List of Pets
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(0..<10, id: \.self) { index in
                        PetCardView(
                            imageName: "image\(index + 1)",
                            breed: "Mixed Breed",
                            colors: "Black, White",
                            gender: "Male",
                            size: "Medium (15-25 kg)",
                            address: "Kpousódou 21, Athína 115 28, Elláda",
                            date: "11/04/2024"
                        )
                    }
                }.padding(.top,10)
            }
            .padding(.top,-10)
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}

// 保持 PetCardView 结构体不变

