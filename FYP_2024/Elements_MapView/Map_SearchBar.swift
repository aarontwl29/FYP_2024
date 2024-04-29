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
                                    ForEach(dropdownOptions, id: \.self) { option in
                                        Button(action: {
                                            self.searchText = option
                                            self.showDropdown = false
                                            onOptionSelected(option)  // Call the closure when an option is selected
                                        }) {
                                            Text(option)
                                                .padding()
                                        }
                                    }
                                }
                                .frame(width: geometry.size.width * 0.6)
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(radius: 5)
                            }
        }
    }
    let dropdownOptions = ["ive (ShaTin)", "ive (TW)", "ive (TY)"]
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
