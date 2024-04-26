import SwiftUI
struct AnimalDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isLiked = false
    @State private var navigateToTapsView = false
    @State private var strayUrgency = "High Urgency "
    
    
    
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
                
                            ButtonBubble(title: "Age", detail: "15 Month")
                            ButtonBubble(title: "Sex", detail: "Female")
                            ButtonBubble(title: "Species", detail: "Cibadak")
                        }
                    }
                    .padding()
                    
                    //新增Table
                    CameraInfoGridView()
                    
                    
                    InfoBubble(buttonInfo: "Adopt this animal")
                    InfoBubble(buttonInfo: "More about animal care").padding(.top, -20)
                }
                .background(Color(.systemGroupedBackground)) // This is the background color similar to the one in your image
                .edgesIgnoringSafeArea(.bottom)
                
            }
        }
    }
}


struct InfoBubble: View {
    var buttonInfo: String
    var body: some View {
        VStack {
            Button(action: {
                // 寫上導航到其他頁面的程式碼
            }) {
                Text(buttonInfo)
                    .foregroundStyle(.red).bold()
            }
            .frame(width:290 , height: 50)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}





struct ButtonBubble: View {
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

struct CameraInfo {
    var camID: String
    var location: String
    var timeStamp: String
    var date: String
}


struct CameraInfoGridView: View {
    let cameraInfos: [CameraInfo] = [
        CameraInfo(camID:"C01", location: "No. 21 Yuen Wo Road, Sha Tin", timeStamp: "10:24 - 11:00", date: "01-03-24"),
        CameraInfo(camID:"C02", location: "No. 22 Yuen Wo Road, Sha Tin", timeStamp: "11:12 - 11:24", date: "02-03-24"),
        CameraInfo(camID:"C03", location: "No. 23 Yuen Wo Road, Sha Tin", timeStamp: "11:32 - 11:54", date: "03-03-24"),
        CameraInfo(camID:"C04", location: "No. 24 Yuen Wo Road, Sha Tin", timeStamp: "12:12 - 13:13", date: "04-03-24"),
        CameraInfo(camID:"C05", location: "No. 25 Yuen Wo Road, Sha Tin", timeStamp: "13:15 - 13:19", date: "05-03-24")
    ]

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: -45),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 25),
        GridItem(.flexible(), spacing: 0)
    ]

    func truncatedLocation(_ location: String) -> String {
        let maxLength = 10
        return location.count > maxLength ? String(location.prefix(maxLength)) + "..." : location
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                Text("ID").bold().foregroundStyle(.blue)
                Text("Location").bold().foregroundStyle(.blue)
                Text("TimeStamp").bold().foregroundStyle(.blue)
                Text("Date").bold().foregroundStyle(.blue)

                ForEach(cameraInfos, id: \.location) { info in
                    Text(info.camID)
                    
                    Button(action: {
                        // 寫上導航到其他頁面的程式碼
                    }) {
                        Text(self.truncatedLocation(info.location)).foregroundStyle(.black)
                    }
                    .frame(width:90 , height: 40)
                    .background(Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                    Button(action: {
                        // 寫上導航到其他頁面的程式碼
                    }) {
                        Text(info.timeStamp).foregroundStyle(.black)
                    }
                    .frame(width:105 , height: 40)
                    .background(Color.yellow)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                    Text(info.date)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}






