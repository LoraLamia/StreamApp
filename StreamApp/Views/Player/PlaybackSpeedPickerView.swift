//
//  PlaybackSpeedPickerView.swift
//  StreamApp
//

import SwiftUI

struct PlaybackSpeedPickerView: View {
    @Bindable var viewModel: StreamPlayerViewModel

    var body: some View {
        Picker("Speed", selection: $viewModel.selectedSpeed) {
            ForEach(PlaybackSpeed.allCases) { speed in
                Text(speed.label).tag(speed)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    PlaybackSpeedPickerView(viewModel: StreamPlayerViewModel(stream: SampleContent.bigBuckBunnyStream))
        .padding()
}
