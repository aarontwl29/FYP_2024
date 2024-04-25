import SwiftUI
struct AnimalDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isLiked = false
    @State private var navigateToTapsView = false // 控制導航到 TapsView 的狀態
    @State private var strayName = "Lucas"
    
    @Binding var selectedAnnotation : CustomAnnotation?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    
                    
                    Button(action: {
                                            // Dismiss the current view
                                            presentationMode.wrappedValue.dismiss()
                                        }) {
                                            Image(systemName: "chevron.left")
                                                .font(.title)
                                                .foregroundStyle(.black)
                                        }
                                        .padding(.leading, 20)
                                        .padding(.bottom, 10)
                    
                    Spacer()
                    
                    Button(action: {
                        // 觸發導航到 TapsView
                        self.navigateToTapsView = true
                    }) {
                        Text(strayName)
                            .font(.title)
                            .foregroundStyle(.blue)
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                    
                    Spacer()
                    
                    Button(action: {
                        self.isLiked.toggle()
                    }) {
                        Image(systemName: isLiked ? "bookmark.fill" : "bookmark")
                            .foregroundColor(isLiked ? .green : .black)
                            .font(.title)
                    }
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
                }
                .background(Color.white) // 給按鈕添加半透明的背景色，以便它們在圖片之上突出顯示
                
                Image("img_ad_content1")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.top) // 讓圖片延伸到頂部的安全區之外
                    .padding(.bottom, -20)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Hachiko - Maltese title
                        Text("Hachiko - Maltese")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        // Information bubbles
                        HStack {
                            InfoBubble(title: "Age", detail: "15 Month")
                            InfoBubble(title: "Sex", detail: "Female")
                            InfoBubble(title: "Location", detail: "Cibadak")
                        }
                    }
                    .padding()
                }
                .background(Color(.systemGroupedBackground)) // This is the background color similar to the one in your image
                .edgesIgnoringSafeArea(.bottom)
                
            }
            
            
            
        }
    }
}


struct InfoBubble: View {
    var title: String
    var detail: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(detail)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}

struct AnimalDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetailsView(selectedAnnotation: .constant(nil))
    }
}
