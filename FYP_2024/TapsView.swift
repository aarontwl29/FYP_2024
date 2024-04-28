import SwiftUI

struct TapsView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }

    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FavouriteView()
                .tabItem {
                    Label("Favourite", systemImage: "star")
                }
            
            BlogView()
                .tabItem {
                    Label("Blog", systemImage: "newspaper")
                }
            
            DonateView()
                .tabItem {
                    Label("Donate", systemImage: "dollarsign.circle")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle") 
                }
        }
    }
}





struct TapsView_Previews: PreviewProvider {
    static var previews: some View {
        TapsView()
    }
}
