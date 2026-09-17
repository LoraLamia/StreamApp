//
//  StreamPlayerView.swift
//  StreamApp
//
//  Root screen: video surface, transport controls and stream details.
//

import SwiftUI

struct StreamPlayerView: View {
    @State private var viewModel = StreamPlayerViewModel(stream: .bigBuckBunny)

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VideoSurfaceView(viewModel: viewModel)
                PlaybackControlsView(viewModel: viewModel)
                StreamInfoView(viewModel: viewModel)
                Spacer()
            }
            .padding()
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    StreamPlayerView()
}
