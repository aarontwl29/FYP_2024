import SwiftUI

struct SwiftUIView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }

    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ContentView()
                .tabItem {
                    Label("Favourite", systemImage: "star")
                }
            
            ContentView()
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
