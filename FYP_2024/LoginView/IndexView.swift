import SwiftUI

struct IndexView: View {
    @State private var showingLoginView = false // 控制LoginView顯示的變量
    @State private var showingRegistView = false // 控制LoginView顯示的變量
    var body: some View {
        VStack {
            Spacer()
            
            // Logo部分可以放在這裡，如果有圖片的話
            Image("AppIcon1").resizable().aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome to Stray Sentinel")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Text("Stray Sentinel is an app dedicated to those who care for stray cats and dogs! Whether you're a regular user, a volunteer, or part of a stray animal organization, this app helps you better care for and rescue stray cats and dogs.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 10)
            }
            .padding()
            
            VStack(spacing: 20) {
                Button(action: {
                    self.showingLoginView = true // 設置為true時顯示LoginView
                }) {
                    Text("Login")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showingLoginView) {
                    LoginView() // 這裡放置你的LoginView
                }
                
                Button(action: {
                    self.showingRegistView = true // 設置為true時顯示LoginView
                }) {
                    Text("Register")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                .sheet(isPresented: $showingRegistView) {
                    RegisterView() // 這裡放置你的LoginView
                }
                
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(
            Image("index_bg") // 使用你的背景圖片名稱
                .resizable()
                .aspectRatio(contentMode: .fill) // 填滿而不失去比例
                .edgesIgnoringSafeArea(.all) // 讓背景延伸到安全區域之外
        )
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
