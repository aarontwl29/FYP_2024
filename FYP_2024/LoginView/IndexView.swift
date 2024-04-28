import SwiftUI

struct IndexView: View {
    @State private var showingLoginView = false
    @State private var showingRegistView = false
    @Binding var isPresented: Bool // 新增一個綁定變量來控制顯示狀態

    var body: some View {
        VStack {
            Spacer()
            
            Image("AppIcon1").resizable().aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome to Stray Sentinel")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Text("Stray Sentinel is an app dedicated to those who care for stray cats and dogs!")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 10)
            }
            .padding()
            
            VStack(spacing: 20) {
                Button(action: {
                    self.showingLoginView = true
                }) {
                    Text("Login")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showingLoginView) {
                    LoginView()
                }
                
                Button(action: {
                    self.showingRegistView = true
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
                    RegisterView()
                }

                // 新增Skip按鈕
                Button("Skip") {
                    isPresented = false // 點擊時將isPresented設置為false，從而關閉視圖
                }
                .font(.subheadline)
                .foregroundColor(.black)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(
            Image("index_bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView(isPresented: .constant(true))
    }
}
