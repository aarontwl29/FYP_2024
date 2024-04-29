import SwiftUI

struct MyReportsView: View {
    // 假設這些是從你的後台或模型中獲取的資料
    let numPost: Int = 3
    let balanceChange: String = "80%"
    let myPost: [Post] = [
        Post(name: "Puppy", species: "Ragdoll", locationVal: "No. 21 Yuen Wo Road, Sha Tin", date: "17-04-2024", image: "image1")
    ]
    
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
                
                // 交易記錄
                ForEach(myPost) { myPost in
                    HStack {
                        Image(myPost.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64, height: 64)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8).padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            Text(myPost.name)
                                .font(.headline)
                            Text(myPost.species)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(myPost.locationVal)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(myPost.date)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {
                            showPayment.toggle()
                        }) {
                            Text("Detail")
                        }
                        
                    }
                }
                
            }
            .navigationTitle("History")
            .sheet(isPresented: $showPayment) {
                MyPostDetailsView( selectedAnnotation: .constant(nil)) // Present PaymentView as a modal sheet
            }
        }
    }
}

// 一個簡單的交易模型
struct Post: Identifiable {
    var id = UUID()
    let name: String
    let species: String
    let locationVal: String
    let date: String
    let image: String
}

// 在預覽中顯示視圖
struct MyReportsView_Previews: PreviewProvider {
    static var previews: some View {
        MyReportsView()
    }
}
