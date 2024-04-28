import SwiftUI

struct ProfileView: View {
    @State private var phoneNumber: String = "+852 5421 6311"
    @State private var email: String = "tony8521@icloud.com"
    @State private var username: String = "tony143625"
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var cardNumber: String = "+852 5421 6311"
    
    

    var body: some View {
        VStack {
            Image("img_icon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle()) 
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)

            Text(username)
                .font(.title)
                .fontWeight(.medium)

            Form {
                Section(header: Text("Username")) {
                    TextField("Username", text: $username)
                }
                
                Section(header: Text("Password")) {
                    SecureField("New Password", text: $newPassword) // 改為SecureField隱藏密碼
                    SecureField("Confirm New Password", text: $confirmPassword)
                }
                
                Section(header: Text("Contact Information")) {
                    TextField("Phone number", text: $phoneNumber)
                    TextField("Email id", text: $email)
                }
                
                Section {
                    Button("Save") {
                        // 在這裡添加你需要執行的操作，例如保存數據
                    }
                    .frame(maxWidth: .infinity, alignment: .center) // 使按鈕寬度最大並置中
                    .background(Color.white) // 設定按鈕背景色
                    .foregroundColor(.blue) // 設定文字顏色
                    .cornerRadius(8) // 設定按鈕角的圓角大小
                }
            }
        }
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
