import SwiftUI

struct DonateResultView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            VStack{
                Image("img_bl_icon1") // 這裡用系統圖示來代表心形，實際上可能需要自己的圖片
                    .font(.system(size: 100)) // 設定圖示大小
                    .padding() // 四周留空間
                    .cornerRadius(25) // 圓角
                    .foregroundColor(.white) // 圖示顏色

                Text("Thank you for your donation!")
                    .font(.title) // 字體大小
                    .foregroundStyle(.blue)
                    .bold()
                    .padding() // 四周留空間
            }
            .padding(.bottom,120)

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

            }
            .padding()
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            .frame(width: 330, height: 20)
            
            

            Spacer()
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
                        .padding(.top, 20)
                }
            }
            .padding() // 四周留空間
        }
        .background(Color.white) // 整個VStack的背景色
        .cornerRadius(20) // 整個VStack的圓角
        .padding() // 整個VStack的四周留空間
    }
}

struct DonateResultView_Previews: PreviewProvider {
    static var previews: some View {
        DonateResultView()
    }
}
