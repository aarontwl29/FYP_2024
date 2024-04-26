import SwiftUI
struct AnimalDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isLiked = false
    @State private var navigateToTapsView = false
    @State private var strayUrgency = "High Urgency "
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: TapsView(), isActive: $navigateToTapsView) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        // 觸發導航到 TapsView
                        self.navigateToTapsView = true
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
                        Image(systemName: "exclamationmark.shield")
                            .font(.title)
                            .foregroundStyle(.red)
                            .bold()
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
                            .foregroundStyle(.blue)
                        
                        // Information bubbles
                        HStack {
                
                            InfoBubble(title: "Age", detail: "15 Month")
                            InfoBubble(title: "Sex", detail: "Female")
                            InfoBubble(title: "Species", detail: "Cibadak")
                        }
                    }
                    .padding()
                    
                    //新增Table
                    CameraInfoGridView()
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
        AnimalDetailsView()
    }
}

struct CameraInfo {
    var location: String
    var timeStamp: String
    var date: String
}


struct CameraInfoGridView: View {
    // 這裡是我們的假數據
    let cameraInfos: [CameraInfo] = [
        CameraInfo(location: "No. 21 Yuen Wo Road, Sha Tin", timeStamp: "10:00 AM", date: "2024-04-26"),
        CameraInfo(location: "No. 22 Yuen Wo Road, Sha Tin", timeStamp: "10:05 AM", date: "2024-04-26"),
        CameraInfo(location: "No. 23 Yuen Wo Road, Sha Tin", timeStamp: "10:10 AM", date: "2024-04-26"),
        CameraInfo(location: "No. 24 Yuen Wo Road, Sha Tin", timeStamp: "10:15 AM", date: "2024-04-26"),
        CameraInfo(location: "No. 25 Yuen Wo Road, Sha Tin", timeStamp: "10:20 AM", date: "2024-04-26")
    ]
    
    // 這裡定義了每一列的格式
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible())
    ]
    
    
    
    func truncatedLocation(_ location: String) -> String {
            let maxLength = 21
            return location.count > maxLength ? String(location.prefix(maxLength)) + "..." : location
        }
    
    
    
    var body: some View {
        ScrollView {
            // 使用LazyVGrid來創建網格布局
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                // 每一列的標題
                
                Text("Location").bold().foregroundStyle(.blue)
                Text("TimeStamp").bold().foregroundStyle(.blue)
                Text("Date").bold().foregroundStyle(.blue)
                
                // 循環創建每行數據
                ForEach(cameraInfos, id: \.location) { info in
                                    Text(self.truncatedLocation(info.location))
                                    Text(info.timeStamp)
                                    Text(info.date)
                                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}





