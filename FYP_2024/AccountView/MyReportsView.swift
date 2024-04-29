import SwiftUI

struct MyReportsView: View {
    // 假設這些是從你的後台或模型中獲取的資料
    @State private var numPost: Int = 0
    @State private var reports: [Report_UIImage] = []
    @State private var showDetails = false
    @State private var selectedReport: Report_UIImage?
    
    var body: some View {
        NavigationView {
            List {
                // Section for displaying the header
                Section(header: Text("My Posts")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.blue)) {
                        HStack {
                            Text("Total: \(numPost)")
                                .font(.title3)
                                .padding(.top, -10)
                            Spacer()
                        }
                    }
                
                // Section for displaying reports
                ForEach(reports, id: \.id) { report in
                    PetCardView(report: report, onDetailTap: {
                        self.selectedReport = report
                        self.showDetails = true
                    })
                }
            }
            .navigationTitle("History")
            .sheet(isPresented: $showDetails) {
                if let selectedReport = selectedReport {
                    MyPostDetailsView(report: selectedReport)
                }
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
        var onDetailTap: () -> Void
        
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
                Button(action: onDetailTap) {
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



