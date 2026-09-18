//
//  StreamPlayerView.swift
//  StreamApp
//
//  Player screen: video surface, transport controls and stream details.
//  Pushed from the catalog with the stream to play.
//

import SwiftUI

struct StreamPlayerView: View {
    @State private var viewModel: StreamPlayerViewModel

    init(stream: Stream) {
        _viewModel = State(initialValue: StreamPlayerViewModel(stream: stream))
    }

    var body: some View {
        VStack(spacing: 24) {
            VideoSurfaceView(viewModel: viewModel)
            PlaybackControlsView(viewModel: viewModel)
            StreamInfoView(viewModel: viewModel)
            Spacer()
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
        .navigationTitle(viewModel.title)
        #if !os(tvOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .task {
            viewModel.start()
        }
    }
}

#Preview {
    NavigationStack {
        StreamPlayerView(stream: SampleContent.bigBuckBunnyStream)
    }
}
