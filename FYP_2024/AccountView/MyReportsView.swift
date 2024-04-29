import SwiftUI

struct MyReportsView: View {
    // 假設這些是從你的後台或模型中獲取的資料
    @State private var numPost: Int = 0
//    let balanceChange: String = "80%"
//    let myPost: [Post] = [
//        Post(name: "Puppy", species: "Ragdoll", locationVal: "No. 21 Yuen Wo Road, Sha Tin", date: "17-04-2024", image: "image1")
//    ]
    @State private var reports: [Report_UIImage] = []
    
    @State private var showPayment = false
    
    
    var body: some View {
        NavigationView {
            List {
                // 當前餘額
                VStack(alignment: .leading) {
                    Text("My Posts")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.blue)
                    HStack {
                        Text("Total: " + numPost.codingKey.stringValue)
                            .font(.title3)
                            .padding(.top, -10)
                        Spacer()
                    }
                }
                
                ForEach(reports) { report in
                    PetCardView(report: report, showPayment: $showPayment)
                }
                
                
            }
            .navigationTitle("History")
            .sheet(isPresented: $showPayment) {
                MyPostDetailsView( selectedAnnotation: .constant(nil)) // Present PaymentView as a modal sheet
            }
        }
        .onAppear {
            Task {
                await performAutomaticAction_()
            }
        }
    }
    
    
    func performAutomaticAction_() async  {
        do {
            let reports = try await performAPICall_Reports()
            for report_ in reports {
                var report = Report_UIImage(
                    report: report_
                )
                self.numPost += 1

//                let hardcodedImageUrl = report_.image
                if let urlString = report_.image, let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        report.uiImage = image
                    }
                }
                
                if let album = report_.album {
                    for urlString in album {
                        if let url = URL(string: urlString) {
                            do {
                                let (data, _) = try await URLSession.shared.data(from: url)
                                if let image = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        report.uiImages.append(image)
                                    }
                                }
                            } catch {}
                        }
                    }
                }
        
                if(report.uiImage != nil){
                    print("UIImage: " , report.uiImage)
                }else{
                    print("nil!")
                }
                self.reports.append(report)
            }
        } catch {}
    }
    
    struct PetCardView: View {
        
        var report: Report_UIImage
        @Binding var showPayment: Bool

        var body: some View {
            HStack {
                
                
                if let uiImage = report.uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.trailing, 10)
                } else {
                                // Provide a default view or image if uiImage is nil
                                Image(systemName: "photo")
                                    .resizable()
                                    // ... other modifiers ...
                            }
                
                
                
                
                VStack(alignment: .leading) {
                    Text(report.report.nickName)
                        .font(.headline)
                    Text(report.report.breed)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("30 April")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    self.showPayment.toggle()
                }) {
                    Text("Detail")
                }
            }
        }
    }
}

//// 一個簡單的交易模型
//struct Post: Identifiable {
//    var id = UUID()
//    let name: String
//    let species: String
//    let locationVal: String
//    let date: String
//    let image: String
//}

// 在預覽中顯示視圖
struct MyReportsView_Previews: PreviewProvider {
    static var previews: some View {
        MyReportsView()
    }
}


struct Pet {
    var image: String
    var name: String
    var species: String
    var location: String
    var date: String
}



