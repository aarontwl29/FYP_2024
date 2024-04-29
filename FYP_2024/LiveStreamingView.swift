//
//  LiveStreamingView.swift
//  FYP_2024
//
//  Created by itst on 30/4/2024.
//
import SwiftUI
import AVKit

struct LiveStreamingView: View {
    private var player: AVPlayer

    init() {
        guard let path = Bundle.main.path(forResource: "cat1", ofType: "mp4") else {
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
        LiveStreamingView()
    }
}
