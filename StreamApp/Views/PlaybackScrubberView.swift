//
//  PlaybackScrubberView.swift
//  StreamApp
//

import SwiftUI

struct PlaybackScrubberView: View {
    @Bindable var viewModel: StreamPlayerViewModel

    var body: some View {
        VStack(spacing: 4) {
            Slider(value: $viewModel.sliderValue, in: viewModel.sliderRange) { isEditing in
                viewModel.sliderEditingChanged(isEditing)
            }
            .disabled(!viewModel.canScrub)
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
}

#Preview {
    PlaybackScrubberView(viewModel: StreamPlayerViewModel(stream: .bigBuckBunny))
        .padding()
}
