import SwiftUI
import AVKit

struct LiveStreamingView: View {
    private var player: AVPlayer
    private var link: String

    init(link: String) {
        self.link = link
        guard let path = Bundle.main.path(forResource: link, ofType: "mp4") else {
            fatalError("视频文件未找到")
        }
        self.player = AVPlayer(url: URL(fileURLWithPath: path))
    }

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                player.play()
            }
    }
}

struct LiveStreamingView_Previews: PreviewProvider {
    static var previews: some View {
        LiveStreamingView(link: "cat1")
    }
}
