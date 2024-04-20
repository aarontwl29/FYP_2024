import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
                    NavigationLink(destination: TapsView()) {
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
