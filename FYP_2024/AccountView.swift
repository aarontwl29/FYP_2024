import SwiftUI



struct AccountView: View {
    @State private var showProfile = false
    @State private var username: String = "tony143625"
    @State private var email: String = "tony8521@icloud.com"
    
 
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Profile").font(.headline).bold()) {
                    VStack(alignment: .center, spacing: 8) {
                        Image("img_icon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .padding(.bottom, 8)
                        
                        Text(username)
                            .font(.title2)
                            .padding(.bottom, 2)
                        Text(email)
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                        
                        Button(action: {
                            showProfile.toggle()
                            // Button action
                        }) {
                            Text("Edit Profile")
                                .font(.title2)
                                .foregroundStyle(.white)

                        }
                        
                        .frame(width:150 , height: 40)
                        
                        .background(Color.blue)
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                }
                
                Section {
                    ForEach(MenuOption.allCases, id: \.self) { option in
                        NavigationLink(destination: option.destination) {
                            Label(option.title, systemImage: option.imageName)
                                .foregroundColor(.primary)
                                .padding(.vertical)
                                .padding(.horizontal, 10)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .gray.opacity(0.3), radius: 3, x: 1, y: 1)
                        }
                        .listRowSeparator(.hidden)
                    }
                    
                }.padding(.vertical, 2)
                
                Button(action: {
                    
                }) {
                    Label("Logout", systemImage: "arrow.right.square")
                        .foregroundColor(.red)
                        .padding(.vertical)
                        .padding(.horizontal, 10)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.3), radius: 3, x: 1, y: 1)
                }
                .padding(.vertical,2)
                .listRowSeparator(.hidden)
            }
            .listStyle(GroupedListStyle())
        }
        .sheet(isPresented: $showProfile) {
            ProfileView() // Present PaymentView as a modal sheet
        }
    }
    
}

enum MenuOption: CaseIterable {
    case mypost, fav_blog, faq, setting
    
    var title: String {
        switch self {
        case .mypost: return "My reports"
        case .fav_blog: return "Favourite blogs"
        case .faq: return "FAQ"
        case .setting: return "Setting"
        }
    }
    
    var imageName: String {
        switch self {
        case .mypost: return "message.badge"
        case .fav_blog: return "heart.text.square"
        case .faq: return "exclamationmark.bubble"
        case .setting: return "gearshape"
        }
    }
    
    @ViewBuilder var destination: some View {
        switch self {
        case .mypost:
            MyReportsView()
        case .fav_blog:
            MyFavBlogsView()
        case .faq:
            FAQView()
        case .setting:
            SettingView()
        }
    }
}


struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
