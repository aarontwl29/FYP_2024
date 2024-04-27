//
//  RegisterView.swift
//  FYP_2024
//
//  Created by itst on 26/4/2024.
//

import SwiftUI

struct RegisterView: View {
    //userAccount array
    @State private var username: String = ""
    @State private var user_email: String = ""
    @State private var password: String = ""
    @State private var confirm_password: String = ""
    @State private var showError: Bool = false // 用於顯示錯誤訊息的變量
    @Environment(\.presentationMode) var presentationMode
    
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
            
            Text("Sign up")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            //新增貫穿的橫線
            Divider()
                .padding(.vertical, 10)
            
            TextField("Email *", text: $user_email)
                .font(.title2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 1)
            
            TextField("Username *", text: $username)
                .font(.title2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 1)
            
            SecureField("Password *", text: $password)
                .font(.title2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 1)
            
            SecureField("Confirm Password *", text: $password)
                .font(.title2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 1)
            
            
            
            // "or" 設定為橫向置中
            
            
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
            
            Button(action:{
                
            }
            ) {
                Text("Submit")
                
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.black)
                    .cornerRadius(25)
            }.padding(.top,10)
            
            
            HStack {
                Text("Already have an account ?")
                    .foregroundColor(.gray)
                Button(action: {
                    // 註冊的動作
                }) {
                    Text("Login")
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
