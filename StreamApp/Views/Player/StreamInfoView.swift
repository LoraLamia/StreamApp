//
//  StreamInfoView.swift
//  StreamApp
//

import SwiftUI

struct StreamInfoView: View {
    let viewModel: StreamPlayerViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            LabeledContent("Status", value: viewModel.statusDescription)
            LabeledContent("Source") {
                Text(viewModel.sourceDescription)
                    .lineLimit(2)
                    .truncationMode(.middle)
#if !os(tvOS)
.textSelection(.enabled)
#endif
            }
        }
        .font(.footnote)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    StreamInfoView(viewModel: StreamPlayerViewModel(stream: SampleContent.bigBuckBunnyStream))
        .padding()
}
