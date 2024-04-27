import SwiftUI

struct AccountView: View {
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
                        
                        Text("TONY HO")
                            .font(.title2)
                            .padding(.bottom, 2)
                        Text("ttighaw@icloud.com")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                        
                        Button(action: {
                            // Button action
                        }) {
                            Text("Edit Profile")
                                .font(.title2)
                                .foregroundStyle(.blue)
                                .bold()
                        }
                        .frame(width:290 , height: 50)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                }
                
                Section {
                    ForEach(MenuOption.allCases, id: \.self) { option in
                        NavigationLink(destination: Text(option.destination)) {
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
                    // Logout action
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
    }
}

enum MenuOption: CaseIterable {
    case mypost, fav_blog, my_notifications, faq, setting
    
    var title: String {
        switch self {
        case .mypost: return "My reports"
        case .fav_blog: return "Favourite blogs"
        case .my_notifications: return "My notifications"
        case .faq: return "FAQ"
        case .setting: return "Setting"
        }
    }
    
    var imageName: String {
        switch self {
        case .mypost: return "message.badge"
        case .fav_blog: return "heart.text.square"
        case .my_notifications: return "bell.badge"
        case .faq: return "exclamationmark.bubble"
        case .setting: return "gearshape"
        }
    }
    
    var destination: String {
        "Destination View for \(self.title)"
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
