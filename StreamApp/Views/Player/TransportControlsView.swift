//
//  TransportControlsView.swift
//  StreamApp
//

import SwiftUI

struct TransportControlsView: View {
    let viewModel: StreamPlayerViewModel

    var body: some View {
        HStack(spacing: 32) {
            Button {
                viewModel.skipBackward()
            } label: {
                Image(systemName: "gobackward.10")
            }
            .accessibilityLabel("Back 10 seconds")

            Button {
                viewModel.togglePlayPause()
            } label: {
                Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 44))
                    .contentTransition(.symbolEffect(.replace))
            }
            .accessibilityLabel(viewModel.isPlaying ? "Pause" : "Play")

            Button {
                viewModel.skipForward()
            } label: {
                Image(systemName: "goforward.10")
            }
            .accessibilityLabel("Forward 10 seconds")
        }
        .font(.title)
        .disabled(!viewModel.isReady)
    }
}

#Preview {
    TransportControlsView(viewModel: StreamPlayerViewModel(stream: SampleContent.bigBuckBunnyStream))
        .padding()
}
