import SwiftUI
// Donation data model
struct DonationData {
    var imageName: String
    var organizationName: String
    var description: String
    var detailDescription: String
    var instagramURL: String
    var facebookURL: String
    var websiteURL: String
}


struct DonationCardView: View {
    var donation: DonationData
    @State private var isLiked = false  // State to track if the heart is 'liked'
    @State private var showDetails = false  // State to control the visibility of the Bottom Sheet
    @State private var showPayment = false

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

            // Buttons Configuration
            HStack {
                Button(action: {
                    isLiked.toggle()
                }) {
                    Image(systemName: isLiked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(isLiked ? .green : .gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(width: 44, height: 44)
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())

                Spacer()

                Button(action: {
                    showDetails.toggle() 
                     // Toggle the state to show the Bottom Sheet
                }) {
                    ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.green)
                                .frame(width: 100, height: 44)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .shadow(radius: 0.5)
                            
                            Image(systemName: "book.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                        }
                }
                .frame(width: 100, height: 44)
                .background(Color.green)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .shadow(radius: 0.5)
                

                Button(action: {
                                    showPayment.toggle()
                                }) {
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
        .sheet(isPresented: $showDetails) {
            // Pass the donation data to the detail view
            DonationDetailView(donation: donation)
            
            
        }
        .sheet(isPresented: $showPayment) {
            PaymentView() // Present PaymentView as a modal sheet
        }
    }
}



// 修改 DonateView 來使用這些新資料
struct DonateView: View {
    @State private var selectedTab = "Organization"
    let donations = [
        DonationData(imageName: "img_bl_icon1", organizationName: "HKSCDA", description: "An organization focusing on special dental care education in Hong Kong.", detailDescription: "The Hong Kong Special Care Dental Association focuses on providing specialized dental care and education for individuals with special needs. It aims to enhance oral health through professional dental services, educational workshops, and resources for caregivers.", instagramURL: "https://www.instagram.com/hkscda", facebookURL: "https://www.facebook.com/hkscda", websiteURL: "https://www.google.com.hk/"),
        DonationData(imageName: "img_bl_icon2", organizationName: "HKDR_HK", description: "Dedicated to rescuing homeless dogs and finding adoptive families.", detailDescription: "Hong Kong Dog Rescue is committed to rescuing homeless dogs and providing them with the care they need until they are adopted into loving homes. They also engage in community education to raise awareness about animal welfare." ,instagramURL: "https://www.instagram.com/hkscda", facebookURL: "https://www.facebook.com/hkscda", websiteURL: "https://www.google.com.hk/"),
        DonationData(imageName: "img_bl_icon3", organizationName: "LAP_HK", description: "Offers animal rescue and adoption services for abused or abandoned animals.", detailDescription: "Lifelong Animal Protection Charity provides rescue and adoption services for abused and abandoned animals. By offering shelter and rehabilitation, they also advocate for animal rights and educate the community on responsible pet ownership." ,instagramURL: "https://www.instagram.com/hkscda", facebookURL: "https://www.facebook.com/hkscda", websiteURL: "https://www.google.com.hk/"),
        DonationData(imageName: "img_bl_icon4", organizationName: "SPCA", description: "Prevents animal cruelty and promotes welfare with shelter services.", detailDescription: "The Society for the Prevention of Cruelty to Animals operates shelters and provides care to mistreated and abandoned animals. They also conduct educational programs and advocate for animal rights legislation." ,instagramURL: "https://www.instagram.com/hkscda", facebookURL: "https://www.facebook.com/hkscda", websiteURL: "https://www.google.com.hk/"),
        DonationData(imageName: "img_bl_icon5", organizationName: "Villa Kunterbunt Lantau", description: "Focuses on animal welfare, providing shelter and adoption on Lantau Island.", detailDescription: "Villa Kunterbunt Lantau offers a sanctuary for animals on Lantau Island, promoting animal welfare through shelter, adoption, and education initiatives aimed at changing public attitudes towards animal rights.", instagramURL: "https://www.instagram.com/hkscda", facebookURL: "https://www.facebook.com/hkscda", websiteURL: "https://www.google.com.hk/"),
        DonationData(imageName: "img_bl_icon6", organizationName: "Tobby's Friends Adoption", description: "Provides temporary homes for homeless dogs until permanent adoption.", detailDescription: "Tobby's Friends Adoption focuses on providing temporary foster care for homeless dogs, facilitating their health and well-being while seeking permanent, loving homes for them.",instagramURL: "https://www.instagram.com/hkscda", facebookURL: "https://www.facebook.com/hkscda", websiteURL: "https://www.google.com.hk/")
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
                        .stroke(Color.blue, lineWidth: 1)
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


struct DonationDetailView: View {
    var donation: DonationData

    var body: some View {
        VStack {
            Image(donation.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 20)

            Text(donation.organizationName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 20)

            Text(donation.detailDescription)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top,10)

            // Social media buttons
            HStack {
                Button(action: {
                    UIApplication.shared.open(URL(string: donation.instagramURL)!)
                }) {
                    Image("ins_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                .padding(.horizontal, 10)

                Button(action: {
                    UIApplication.shared.open(URL(string: donation.facebookURL)!)
                }) {
                    Image("facebook_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                .padding(.horizontal, 10)

                Button(action: {
                    UIApplication.shared.open(URL(string: donation.websiteURL)!)
                }) {
                    Image("web_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                .padding(.horizontal, 10)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .cornerRadius(20)
        .padding()
    }
}





// 預覽代碼保持不變
struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}


