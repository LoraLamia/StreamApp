//
//  VideoSurfaceView.swift
//  StreamApp
//

import SwiftUI

struct VideoSurfaceView: View {
    let viewModel: StreamPlayerViewModel

    var body: some View {
        PlayerLayerView(player: viewModel.player)
            .aspectRatio(16 / 9, contentMode: .fit)
            .overlay { overlay }
            .clipShape(.rect(cornerRadius: 12))
            .accessibilityLabel("Video")
    }

    @ViewBuilder
    private var overlay: some View {
        switch viewModel.videoOverlay {
        case .none:
            EmptyView()
        case .loading:
            ProgressView("Loading stream…")
                .tint(.white)
                .foregroundStyle(.white)
        case .buffering:
            ProgressView()
                .tint(.white)
        case .error(let message):
            ContentUnavailableView {
                Label("Playback failed", systemImage: "exclamationmark.triangle")
            } description: {
                Text(message)
            } actions: {
                Button("Retry") {
                    viewModel.retry()
                }
                .buttonStyle(.borderedProminent)
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    VideoSurfaceView(viewModel: StreamPlayerViewModel(stream: .bigBuckBunny))
        .padding()
}
