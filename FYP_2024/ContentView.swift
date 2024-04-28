import SwiftUI

struct ContentView: View {
    @State private var showIndexView = false

    var body: some View {
        TapsView()
        .fullScreenCover(isPresented: $showIndexView) {
            // 傳遞 `showIndexView` 狀態透過綁定到 IndexView
            IndexView(isPresented: $showIndexView)
        }
        .onAppear {
            // 延遲一秒後顯示 IndexView
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
