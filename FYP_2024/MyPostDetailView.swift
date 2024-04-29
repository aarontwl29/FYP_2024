import SwiftUI
import SwiftUI

struct MyPostDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var images: [UIImage] = []
    var report: Report_UIImage
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    ImagePreviewArea(images: $images)
                }
                .onAppear {
                    if let uiImage = report.uiImage {
                        images = [uiImage] // Update the images array with the uiImage
                        for image in report.uiImages {
                            images.append(image)
                        }
                    }
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(report.report.nickName)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.blue)
                        
                        HStack {
                            DetailBubble(title: "Age", detail: String(report.report.age) + " years")
                            DetailBubble(title: "Sex", detail: report.report.gender)
                            DetailBubble(title: "Species", detail: report.report.breed)
                        }
                        HStack {
                            DetailBubble(title: "Main Color", detail: report.report.color)
                            DetailBubble(title: "Neutered", detail: report.report.neuteredStatus)
                            DetailBubble(title: "Health", detail: report.report.healthStatus)
                        }
                    }
                    .padding()
                    
                    CameraInfoGridView(reportInfo: [
                        ReportInfo(location: "No. 21 Yuen Wo Road, Sha Tin",
                                   appearTime: formatDate(timestamp: report.report.timestamp),
                                   disappearTime: formatDate(timestamp: report.report.timestamp),
                                   date: "30-04-24"), // Corrected 'ate:' to 'date:'
                    ])
                    
                    ScrollView {
                        Button(action: {
                            print("Delete button tapped")
                            deleteReport()
                        }) {
                            InfoBubble(buttonInfo: "Delete")
                        }
                    }
                    .background(Color(.white)) // This is the background color similar to the one in your image
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
            .navigationBarTitle("Details", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func formatDate(timestamp: Int64) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp) / 1000) // Convert milliseconds to seconds
        let formatter = DateFormatter()
        formatter.dateFormat = "HH : mm" // Set the format you want
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // Set UTC time zone
        formatter.locale = Locale(identifier: "en_US_POSIX") // Set locale to POSIX to ensure consistent formatting
        return formatter.string(from: date)
    }
    
    func deleteReport() {
        print("Attempting to delete report")
        guard let url = URL(string: "https://fyp2024.azurewebsites.net/reports/\(report.report.reportId)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: Invalid response or status code")
                return
            }
            print("Report deleted successfully")
            
            DispatchQueue.main.async {
                presentationMode.wrappedValue.dismiss()
            }
        }.resume()
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



struct DetailBubble: View {
    var title: String
    var detail: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.footnote)
                .foregroundColor(.blue)
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

struct ReportInfo {
    var location: String
    var appearTime: String
    var disappearTime: String
    var date: String
}


struct CameraInfoGridView: View {
    
    let reportInfo: [ReportInfo]
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 0)
    ]
    
    func truncatedLocation(_ location: String) -> String {
        let maxLength = 30
        return location.count > maxLength ? String(location.prefix(maxLength)) + "..." : location
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                Text("Location").bold().foregroundStyle(.blue)
                Text("Appear").bold().foregroundStyle(.blue)
                Text("Dissipate").bold().foregroundStyle(.blue)
                Text("Date").bold().foregroundStyle(.blue)
                
                ForEach(reportInfo, id: \.location) { info in
                    
                    Text(self.truncatedLocation(info.location)).foregroundStyle(.black)
                    
                    Text(self.truncatedLocation(info.appearTime)).foregroundStyle(.black)
                    
                    Text(self.truncatedLocation(info.disappearTime)).foregroundStyle(.black)
                    
                    Text(self.truncatedLocation(info.date)).foregroundStyle(.black)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}


// 定義流浪動物數據結構體
struct StrayAnimal {
    var imageName: String
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
