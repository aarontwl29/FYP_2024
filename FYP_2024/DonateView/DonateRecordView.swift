//
//  DonateRecordView.swift
//  FYP_2024
//
//  Created by itst on 29/4/2024.
//

import SwiftUI

struct DonateRecordView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Text("Record").font(.title).bold().foregroundStyle(.blue).padding(.top,20)
        VStack{
            
            HStack{
                Text("Donation ID:").bold()
                Spacer()
                Text("#42903752368957").foregroundStyle(.blue)
            }
            .padding(.vertical,10)
            
            HStack{
                Text("Organization:").bold()
                Spacer()
                Text("HKSCDA").foregroundStyle(.blue)
            }
            .padding(.vertical,10)
            
            HStack{
                Text("Payment:").bold()
                Spacer()
                Text("Payme").foregroundStyle(.blue)
            }
            .padding(.vertical,10)
            
            HStack{
                Text("Amount:").bold()
                Spacer()
                Text("$50").foregroundStyle(.blue)
            }
            .padding(.vertical,10)
            
            HStack{
                Text("Date:").bold()
                Spacer()
                Text("30-4-2024").foregroundStyle(.blue)
            }
            .padding(.vertical,10)
            
            VStack {
                Button(action: {
                    // 分享的動作
                }) {
                    Text("Share")
                        .font(.title2).bold()
                        .frame(width: 170, height: 20)
                        .foregroundColor(.white) // 文字顏色
                        .padding() // 四周留空間
                        .background(Color.blue) // 背景色
                        .cornerRadius(10) // 圓角
                        
                }
            }
            .padding() // 四周留空間
        }
        
        
        .padding()
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        .frame(width: 330, height: 20)
        .padding(.top, 170)
        Spacer()
        
    }
    
    
}

#Preview {
    DonateRecordView()
}
