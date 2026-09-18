//
//  PlaybackControlsView.swift
//  StreamApp
//
//  Groups the scrubber, transport buttons and speed picker.
//

import SwiftUI

struct PlaybackControlsView: View {
    let viewModel: StreamPlayerViewModel

    var body: some View {
        VStack(spacing: 16) {
            PlaybackScrubberView(viewModel: viewModel)
            TransportControlsView(viewModel: viewModel)
            PlaybackSpeedPickerView(viewModel: viewModel)
        }
    }
}

#Preview {
    PlaybackControlsView(viewModel: StreamPlayerViewModel(stream: SampleContent.bigBuckBunnyStream))
        .padding()
}
