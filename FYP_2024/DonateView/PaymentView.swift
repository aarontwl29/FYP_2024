import SwiftUI


struct PaymentView: View {
    @State private var donationAmount: String = ""
    @State private var selectedAmount: String? = "$10" // 預設為 $10 被選中
    @State private var selectedPaymentMethod: String? = "Payme"
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Donation Amount")
                    .font(.headline)
                    .padding(.top)
                
                // 捐款金額的按鈕
                ForEach(["$10", "$50", "$100", "$250", "$500"], id: \.self) { amount in
                    DonationButtonView(amount: amount, isSelected: .init(
                        get: { selectedAmount == amount },
                        set: { newValue in
                            if newValue {
                                selectedAmount = amount
                                donationAmount = "" // 清空其他金額輸入框
                            }
                        }
                    ))
                }
                
                // 其他金額輸入
                Text("Other Amount")
                    .font(.headline)
                    .padding(.top)
                
                HStack {
                    Text("$")
                    TextField("Enter your donation amount", text: $donationAmount)
                        .keyboardType(.decimalPad)
                        .onChange(of: donationAmount) { newValue in
                            if !newValue.isEmpty {
                                selectedAmount = nil // 清除選中的捐款金額按鈕
                            }
                        }
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                
                // 其他 UI 部件保持不變...
                Text("Payment Method")
                    .font(.headline)
                    .padding(.top)
                
                // 捐款金額的按鈕
                
                // 捐款方式的按鈕
                ForEach(["Payme", "Credit Card", "FPS"], id: \.self) { method in
                    PaymentButtonView(paymentMethod: method, isSelected: .init(
                        get: { selectedPaymentMethod == method },
                        set: { newValue in
                            if newValue {
                                selectedPaymentMethod = method
                            }
                        }
                    ))
                }
                
                
                
                
                // 選擇付款方式的按鈕
                Button("Donate") {
                    // 處理付款方式選擇的動作
                }
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
                .foregroundColor(.black)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                
                Spacer() // 保持按鈕在底部
            }
            .padding()
        }
    }
}





// 預覽提供器
struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}

struct DonationButtonView: View {
    var amount: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: {
            isSelected.toggle() // 點擊時切換狀態
        }) {
            Text(amount)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.green : Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }
    }
}



// 捐款金額按鈕的 View
struct PaymentButtonView: View {
    var paymentMethod: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: {
            isSelected.toggle() // 點擊時切換狀態
        }) {
            Text(paymentMethod)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.green : Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }
    }
}
