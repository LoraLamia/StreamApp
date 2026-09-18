//
//  LiveBadgeView.swift
//  StreamApp
//

import SwiftUI

struct LiveBadgeView: View {
    var body: some View {
        Text("LIVE")
            .font(.caption2.bold())
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.accentColor, in: .rect(cornerRadius: 4))
            .foregroundStyle(.white)
    }
}

#Preview {
    LiveBadgeView()
        .padding()
        .background(.black)
}
