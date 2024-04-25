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
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            // Button action
                        }) {
                            Text("Edit Profile")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.yellow)
                                .cornerRadius(40)
                        }
                        .padding(.bottom,10)
                        .buttonStyle(PlainButtonStyle())
                        .padding(.top, 8)
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
            .background(Image("img_bk2").resizable().scaledToFill())
            .listStyle(GroupedListStyle())
        }
    }
}

enum MenuOption: CaseIterable {
    case mypost, my_notifications, faq, setting, fav_blog
    
    var title: String {
        switch self {
        case .mypost: return "My reports"
        case .fav_blog: return "Blogs"
        case .my_notifications: return "My notifications"
        case .faq: return "FAQ"
        case .setting: return "Setting"
        }
    }
    
    var imageName: String {
        switch self {
        case .mypost: return "message.badge"
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
