import SwiftUI

struct SwiftUIView: View {
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
            
            PostView()
                .tabItem {
                    Label("Post", systemImage: "square.and.pencil")
                }
            
            ContentView()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
