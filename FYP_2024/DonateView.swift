import SwiftUI
// Donation data model
struct DonationData {
    var imageName: String
    var organizationName: String
    var description: String
}

// DonationCardView now takes a DonationData object
struct DonationCardView: View {
    var donation: DonationData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(donation.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                
                VStack(alignment: .leading) {
                    Text(donation.organizationName)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(donation.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 10)
            }
            // 按鈕配置保持不變
            HStack {
                Button(action: {}) {
                    Image(systemName: "heart")
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(width: 44, height: 44)
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "book.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
                .frame(width: 100, height: 44)
                .background(Color.green)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .shadow(radius: 0.5)
                
                Button(action: {}) {
                    Image(systemName: "dollarsign.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
                .frame(width: 100, height: 44)
                .background(Color.yellow)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .shadow(radius: 0.5)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

// 修改 DonateView 來使用這些新資料
struct DonateView: View {
    @State private var selectedTab = "Organization"
    let donations = [
        DonationData(imageName: "img_bl_icon1", organizationName: "HKSCDA", description: "An organization focusing on special dental care education in Hong Kong."),
        DonationData(imageName: "img_bl_icon2", organizationName: "HKDR_HK", description: "Dedicated to rescuing homeless dogs and finding adoptive families."),
        DonationData(imageName: "img_bl_icon3", organizationName: "LAP_HK", description: "Offers animal rescue and adoption services for abused or abandoned animals."),
        DonationData(imageName: "img_bl_icon4", organizationName: "SPCA", description: "Prevents animal cruelty and promotes welfare with shelter services."),
        DonationData(imageName: "img_bl_icon5", organizationName: "Villa Kunterbunt Lantau", description: "Focuses on animal welfare, providing shelter and adoption on Lantau Island."),
        DonationData(imageName: "img_bl_icon6", organizationName: "Tobby's Friends Adoption", description: "Provides temporary homes for homeless dogs until permanent adoption.")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select", selection: $selectedTab) {
                    Text("Organization").tag("Organization")
                    Text("Animal").tag("Animal")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(minHeight: 44)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.yellow, lineWidth: 2)
                        .background(RoundedRectangle(cornerRadius: 0).fill(Color.white))
                        .padding(.vertical, 5)
                )
                .padding(.horizontal, 10)
                ScrollView {
                    ForEach(donations, id: \.imageName) { donation in
                        DonationCardView(donation: donation)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                    }
                }
                .padding(.top, 10)
            }
            .navigationBarTitle(Text("Donation"), displayMode: .inline)
        }
    }
}
// 預覽代碼保持不變
struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}


