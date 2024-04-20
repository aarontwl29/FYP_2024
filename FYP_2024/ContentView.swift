import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
                    NavigationLink(destination: MapView()) {
                        Text("Go to Map View")
                    }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
