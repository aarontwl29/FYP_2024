import SwiftUI

struct Map_SearchBar: View {
    @Binding var searchText: String
    @State private var isEditing = false
    @State private var showFilter = false
    
    @State private var showDropdown = false
    
    
    var onOptionSelected: (String) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: geometry.size.width * 0.1)
                
                HStack {
                    TextField("Search by location or name...", text: $searchText, onEditingChanged: { isEditing in
                        self.isEditing = isEditing
                        // Show dropdown if searchText is "ive"
                        if searchText.lowercased().contains("ive") {
                            self.showDropdown = true
                        } else {
                            self.showDropdown = false
                        }
                    })
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isEditing {
                                Button(action: {
                                    self.searchText = ""
                                    self.showDropdown = false
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .onTapGesture {
                        self.isEditing = true
                    }
                    .animation(.default, value: isEditing)
                    .frame(width: geometry.size.width * 0.6)
                    
                    Button(action: {
                        self.showFilter.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title2)
                            .padding(.leading,40)
                        
                            .cornerRadius(8) // Add corner radius for rounded corners
                        
                    }
                    .sheet(isPresented: $showFilter) {
                        FilterView()
                    }
                    .frame(width: geometry.size.width * 0.2)
                }
                .background(Color(.systemGray6)) // Add background color here
                .cornerRadius(8) // Add corner radius for rounded corners
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .shadow(radius: 0.5)
                
                Spacer()
                    .frame(width: geometry.size.width * 0.1)
                
            }
            if showDropdown {
                
                VStack(alignment: .leading) {
                    ForEach(dropDownAddress, id: \.0) { option in
                        Button(action: {
                                    self.searchText = "\(option.0)\n\(option.1)"
                                    self.showDropdown = false
                                    onOptionSelected(option.0)  // 當選擇一個選項時呼叫這個閉包
                                }) {
                                    VStack(alignment: .leading) {
                                        Text(option.0)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .multilineTextAlignment(.leading)  // 確保多行文本對齊到左邊
                                        Text(option.1)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.leading)  // 確保多行文本對齊到左邊
                                    }
                                    .padding()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(width: 280)
                .background(Color.white)
                .padding(.leading, 37)
                .padding(.top, 40)
                .cornerRadius(5)
                .shadow(radius: 5)
                
                
            }
        }
    }
    let dropDownAddress = [
        ("Hong Kong Institute of Vocational Education, Sha Tin", "21 Yuen Wo Road, Sha Tin"),
        ("Hong Kong Institute of Vocational Education, Tuen Mun", "18 Tsing Wun Rd, Tuen Mun"),
        ("Hong Kong Institute of Vocational Education, Tsing Yi", "20, Tsing Yi Road, Hoshin")
    ]
    
}




//struct Map_SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        Map_SearchBarPreview()
//    }
//
//    struct Map_SearchBarPreview: View {
//        @State private var searchText = ""
//
//        var body: some View {
//            Map_SearchBar(searchText: $searchText)
//        }
//    }
//}
