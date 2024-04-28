import SwiftUI

struct ContentView: View {
    @State private var showIndexView = false

    var body: some View {
        TapsView()
        .fullScreenCover(isPresented: $showIndexView) {
            IndexView(isPresented: $showIndexView)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showIndexView = true
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
