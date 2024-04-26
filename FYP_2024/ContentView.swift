import SwiftUI

struct ContentView: View {
    @State private var showIndexView = false

    var body: some View {
        TapsView()
            .sheet(isPresented: $showIndexView) {
                IndexView()
            }
            .onAppear {
                // 延遲一秒顯示 IndexView
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
