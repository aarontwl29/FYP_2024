import SwiftUI
struct AnimalDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isLiked: Bool
    @State private var navigateToTapsView = false
    @State private var strayUrgency = "High Urgency"
    @State private var showPrivacyView = false
    @State private var showFAQView = false
    
    
    @Binding var selectedAnnotation: CustomAnnotation?
    var stray: StrayInfoDetal? {
        guard let animalAnnotation = selectedAnnotation as? AnimalAnnotation else {
            return nil
        }
        return StrayInfoDetal(
            age: String(animalAnnotation.animal.age),
            sex: animalAnnotation.animal.gender,
            species: animalAnnotation.animal.breed,
            color: animalAnnotation.animal.color,
            neutered: animalAnnotation.animal.neuteredStatus,
            health: animalAnnotation.animal.healthStatus
        )
    }
    @State private var images: [UIImage] = []
    
    
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
                        isLiked.toggle()
                    }) {
                        Image(systemName: isLiked ? "bookmark.fill" : "bookmark")
                            .foregroundColor(isLiked ? .blue : .gray)
                            .font(.title)
                        
                    }
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
                }
                .background(Color.white) // 給按鈕添加半透明的背景色，以便它們在圖片之上突出顯示
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    ImagePreviewArea(images: $images)
                }
                .onAppear {
                    if let animalAnnotation = selectedAnnotation as? AnimalAnnotation, let uiImage = animalAnnotation.uiImage {
                        images = [uiImage] // Update the images array with the uiImage
                        for image in animalAnnotation.uiImages{
                            images.append(image)
                        }
                    }
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if let animalAnnotation = selectedAnnotation as? AnimalAnnotation {
                            Text(animalAnnotation.animal.nickName)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.blue)
                            
                        }
                        
                        HStack {
                            DetailBubble(title: "Age", detail: stray?.age ?? "Unknown")
                            DetailBubble(title: "Sex", detail: stray?.sex ?? "Unknown")
                            DetailBubble(title: "Species", detail: stray?.species ?? "Unknown")
                        }
                        HStack {
                            DetailBubble(title: "Main Color", detail: stray?.color ?? "Unknown")
                            DetailBubble(title: "Neutered", detail: stray?.neutered ?? "Unknown")
                            DetailBubble(title: "Health", detail: stray?.health ?? "Unknown")
                        }
                    }
                    .padding()
                    
                    
                    CameraInfoGridView()
                    
                    
                    //新增橫向scrollview
                    
                    
                    // 定義流浪動物數據列表
                    let strayAnimals: [StrayAnimal] = [
                        StrayAnimal(imageName: "milkCat1", species: "Siamese", breed: "Carlee", colors: "White", gender: "Female", size: "Small", address: "21 Yuanhe Road", date: "2023-04-01"),
                        StrayAnimal(imageName: "image3", species: "Royal Canin", breed: "Ginger", colors: "Brown", gender: "Male", size: "Large", address: "21 Yuanhe Road", date: "2023-04-02"),
                        StrayAnimal(imageName: "img_ad_content1", species: "Royal Canin", breed: "Luna", colors: "Tricolor", gender: "Male", size: "Medium", address: "21 Yuanhe Road", date: "2023-04-03")]
                    
                    
                    
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // 略去其他部分，專注於新增的橫向滾動部分
                            Text("Similar Stray Animals")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.blue)
                                .padding([.top], 10)
                                .padding([.bottom], -15)
                                .padding(.leading, 15)
                            
                            
                            
                            
                            // 略去其他部分
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(strayAnimals, id: \.breed) { animal in
                                        SimilarStrayBubble(
                                            imageName:animal.imageName,
                                            species: animal.species,
                                            breed: animal.breed,
                                            colors: animal.colors,
                                            gender: animal.gender,
                                            size: animal.size,
                                            address: animal.address,
                                            date: animal.date
                                        )
                                    }
                                }
                                .padding() 
                            }
                        }
                        .background(Color(.white))
                        .edgesIgnoringSafeArea(.bottom)
                        
                        
                        
                        
                        
                        InfoBubble(buttonInfo: "Adopt this animal", action: {showPrivacyView.toggle()})
                        InfoBubble(buttonInfo: "More about animal care", action: {showFAQView.toggle()})
                            .padding(.top, -20)
                    }
                    .background(Color(.white)) // This is the background color similar to the one in your image
                    .edgesIgnoringSafeArea(.bottom)
                    
                }
                
            }
        }
        .sheet(isPresented: $showPrivacyView) {
            AdoptView(contact: PersonContact(imageUrl: "img_bl_icon1", name: "Alex Avalos", phone: "+852 5721 4211", email: "alex@example.com", organization: "HKSCDA"))
        }
        .sheet(isPresented: $showFAQView) {
            FAQView()
        }
        
        
        
    } 
    
    
    struct InfoBubble: View {
        var buttonInfo: String
        var action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    Text(buttonInfo)
                        .foregroundStyle(.red).bold()
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity) // 確保 Text 填滿 Button
            }
            
            .frame(width: 290, height: 50) // 指定 Button 的大小
            .contentShape(Rectangle()) // 使整個矩形區域都能響應點擊
            .background(Color.white)
            
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
            .cornerRadius(10)
            .shadow(radius: 1)
            
        }
    }
    
    
    
    
    
    
    struct SimilarStrayBubble: View {
        var imageName: String
        var species: String
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
                            .font(.headline).foregroundStyle(.blue)
                        Text(species)
                            .font(.subheadline)
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
                    Text("Similar 75%")
                        .font(.subheadline).foregroundStyle(.red).bold()
                }
                
                .padding([.leading, .bottom, .trailing])
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
        } 
    }
    
    
    
    struct DetailBubble: View {
        var title: String
        var detail: String
        
        var body: some View {
            VStack {
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .bold()
                Text(detail)
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
        }
    }
    
    
    
    struct CameraInfo {
        var camID: String
        var location: String
        var timeStamp: String
        var date: String
    }
    
    
    struct CameraInfoGridView: View {
        @State private var showVideo = false
        @State private var showCamera = false
        
        let cameraInfos: [CameraInfo] = [
            CameraInfo(camID:"C32", location: "No. 21 Yuen Wo Road, Sha Tin", timeStamp: "10:24 - 10:30", date: "30-04-24"),
            CameraInfo(camID:"C14", location: "No. 22 Yuen Wo Road, Sha Tin", timeStamp: "11:12 - 11:24", date: "18-04-24"),
            CameraInfo(camID:"C03", location: "No. 23 Yuen Wo Road, Sha Tin", timeStamp: "11:32 - 11:54", date: "14-04-24"),
            CameraInfo(camID:"C02", location: "No. 24 Yuen Wo Road, Sha Tin", timeStamp: "12:12 - 13:13", date: "04-03-24"),
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
                            showCamera.toggle()
                            
                        }) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(Color.black)
                                .font(.title2)
                        }
                        .frame(width:90 , height: 40)
                        .background(Color.green)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        
                        Button(action: {
                            // 寫上導航到其他頁面的程式碼
                            
                            showVideo.toggle()
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
            .sheet(isPresented: $showCamera) {
                CameraInfoView(cameraInfomation: CameraInfomation(cameraImageUrl: "camera.circle", cameraID: "#4326", cameraAddress: "No. 21 Yuen Wo Road, Sha Tin", cameraPosition: "22°23'26.0\"N 114°11'52.9\"E", numOfCatchStray: "5"))
            }
            .sheet(isPresented: $showVideo) {
                var videoPath = "cat" + String(Int.random(in: 1...4))
                
                LiveStreamingView(link: videoPath)
            }
            
        }
        
    }
    
    
    // 定義流浪動物數據結構體
    struct StrayAnimal {
        var imageName: String
        var species: String
        var breed: String
        var colors: String
        var gender: String
        var size: String
        var address: String
        var date: String
    }
    
    
    struct StrayInfoDetal {
        var age: String
        var sex: String
        var species: String
        var color: String
        var neutered: String
        var health: String
    }
    
    
}

struct AnimalDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetailsView(isLiked: false, selectedAnnotation: .constant(nil))
    }
}








