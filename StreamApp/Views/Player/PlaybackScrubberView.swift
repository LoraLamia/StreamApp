//
//  PlaybackScrubberView.swift
//  StreamApp
//

import SwiftUI

struct PlaybackScrubberView: View {
    @Bindable var viewModel: StreamPlayerViewModel

    var body: some View {
        VStack(spacing: 4) {
            scrubber
                .accessibilityLabel("Playback position")

            HStack {
                Text(viewModel.currentTimeText)
                Spacer()
                Text(viewModel.durationText)
            }
            .font(.caption.monospacedDigit())
            .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private var scrubber: some View {
        #if os(tvOS)
        // tvOS has no Slider (no touch input). RemoteScrubberView takes focus
        // and moves the position with the remote's left/right presses.
        RemoteScrubberView(viewModel: viewModel)
        #else
        Slider(value: $viewModel.sliderValue, in: viewModel.sliderRange) { isEditing in
            viewModel.sliderEditingChanged(isEditing)
        }
        .disabled(!viewModel.canScrub)
        #endif
    }
}

#Preview {
    PlaybackScrubberView(viewModel: StreamPlayerViewModel(stream: SampleContent.bigBuckBunnyStream))
        .padding()
}
