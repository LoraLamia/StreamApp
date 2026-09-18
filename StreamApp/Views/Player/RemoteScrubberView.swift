//
//  RemoteScrubberView.swift
//  StreamApp
//
//  tvOS replacement for Slider. The progress bar can take focus from
//  the Siri Remote; pressing left/right nudges the playback position
//  and the view model commits the seek once the presses stop.
//

#if os(tvOS)
import SwiftUI

struct RemoteScrubberView: View {
    let viewModel: StreamPlayerViewModel

    @FocusState private var isFocused: Bool

    var body: some View {
        ProgressView(
            value: min(viewModel.sliderValue, viewModel.sliderRange.upperBound),
            total: viewModel.sliderRange.upperBound
        )
        .tint(isFocused ? .accentColor : .secondary)
        // A thin bar is hard to notice when focused, so grow it a little.
        .scaleEffect(x: 1, y: isFocused ? 2.5 : 1)
        .animation(.easeOut(duration: 0.15), value: isFocused)
        .padding(.vertical, 8)
        .focusable(viewModel.canScrub)
        .focused($isFocused)
        .onMoveCommand { direction in
            switch direction {
            case .left:
                viewModel.scrubBackward()
            case .right:
                viewModel.scrubForward()
            case .up, .down:
                break
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    RemoteScrubberView(viewModel: StreamPlayerViewModel(stream: SampleContent.bigBuckBunnyStream))
        .padding()
}
#endif
