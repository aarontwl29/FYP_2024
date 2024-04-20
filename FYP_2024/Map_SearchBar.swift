import SwiftUI

struct Map_SearchBar: View {
    @Binding var searchText: String
    @State private var isEditing = false
    @State private var showFilter = false
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: geometry.size.width * 0.1)
                
                HStack {
                    TextField("Search by location or name...", text: $searchText)
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
                        .frame(width: geometry.size.width * 0.5)
                    
                    Button(action: {
                        self.showFilter.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .foregroundColor(.gray)
                    }
                    .sheet(isPresented: $showFilter) {
                        FilterView()
                    }
                    .frame(width: geometry.size.width * 0.3)
                }
                .background(Color.blue) // Add background color here
                .cornerRadius(8) // Add corner radius for rounded corners
                
                Spacer()
                    .frame(width: geometry.size.width * 0.1)
            }
        }
    }
}



struct FilterView: View {
    var body: some View {
        Text("Filter View waiting for update")
    }
}

struct Map_SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        Map_SearchBarPreview()
    }
    
    struct Map_SearchBarPreview: View {
        @State private var searchText = ""
        
        var body: some View {
            Map_SearchBar(searchText: $searchText)
        }
    }
}
