import SwiftUI

struct LoginView: View {
    //userAccount array
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false // 用於顯示錯誤訊息的變量
    @Environment(\.presentationMode) var presentationMode
    
    @State private var userAccounts: [UserAccount] = [
        UserAccount(username: "abc123", password: "abc123", type: UserAccount.AccountType(rawValue: "normal") ?? .normal),
        UserAccount(username: "abc456", password: "abc456", type: UserAccount.AccountType(rawValue: "volunteer") ?? .normal),
        UserAccount(username: "abc678", password: "abc678", type: UserAccount.AccountType(rawValue: "organization") ?? .normal)
    ]
    
    
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button(action: {
                    // 返回上一頁的動作
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .padding(.leading, -12)
                        .font(.title2)
                }
                Spacer()
            }
            .padding()
            
            Text("Let's Sign you in.")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Welcome back\nYou’ve been missed!")
                .font(.title)
                .fontWeight(.light)
                .padding(.bottom, 10)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .bold()
            
            //新增貫穿的橫線
            Divider()
                .padding(.vertical, 10)
            
            TextField("Enter Username", text: $username)
                .font(.title2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 1)
            
            SecureField("Enter Password", text: $password)
                .font(.title2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 1)
            
            
            
            
            
            
            
            
            // "or" 設定為橫向置中
            HStack {
                Spacer()
                Text("or")
                    .foregroundColor(.gray)
                Spacer()
            }
            
            HStack(spacing: 20) {
                Spacer()
                // 社交媒體登入按鈕
                Button(action: {
                    // Google 登入
                }) {
                    
                    // image設定為自動調整圖片導致的變形問題
                    Image("facebook_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit) // 避免圖片變形
                        .frame(width: 44, height: 44) // 設定圖片大小
                }
                
                Button(action: {
                    // LinkedIn 登入
                }) {
                    Image("apple_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit) // 避免圖片變形
                        .frame(width: 44, height: 44) // 設定圖片大小
                        
                }.padding(.top, -5)
                
                Button(action: {
                    // Facebook 登入
                }) {
                    Image("google_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit) // 避免圖片變形
                        .frame(width: 44, height: 44) // 設定圖片大小
                }
                Spacer()
            }
            
            if showError {
                HStack {
                    Spacer()
                    Text("Invalid Username or Password")
                        .foregroundColor(.red)
                    Spacer()
                }
                .transition(.slide)
                .animation(.default)
            }
            
            Button(action:
                    loginAction
                   // 登入按鈕的動作
            ) {
                Text("Login")
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.black)
                    .cornerRadius(25)
            }
            
            .padding(.bottom, 20)
            
            HStack {
                Text("Don’t have an account ?")
                    .foregroundColor(.gray)
                Button(action: {
                    // 註冊的動作
                }) {
                    Text("Register")
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    func loginAction() {
        if let _ = userAccounts.first(where: { $0.username == username && $0.password == password }) {
            // 登入成功，進行下一步操作
            // 這裡可以是跳轉到另一個視圖或者保存用戶的登入狀態
            showError = false // 確保錯誤訊息不顯示
            // 此處插入跳轉到主頁面的代碼
        } else {
            // 登入失敗，顯示錯誤訊息
            showError = true
        }
    }
}




// struct userAccount(username, password, type(normal, volunteer, organization))
struct UserAccount {
    var username: String
    var password: String
    var type: AccountType // 使用enum來定義帳號類型
    
    enum AccountType: String {
        case normal = "Normal"
        case volunteer = "Volunteer"
        case organization = "Organization"
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
