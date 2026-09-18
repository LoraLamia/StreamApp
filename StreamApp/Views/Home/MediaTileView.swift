//
//  MediaTileView.swift
//  StreamApp
//
//  One tile in a catalog row. Tapping (or clicking on the remote) opens the
//  detail screen for the item.
//

import SwiftUI

struct MediaTileView: View {
    let item: MediaItem
    let layout: TileLayout

    var body: some View {
        NavigationLink(value: AppRoute.detail(item)) {
            VStack(alignment: layout == .circle ? .center : .leading, spacing: 8) {
                ArtworkImageView(artwork: item.artwork, title: item.title, requestSize: layout.size)
                    .frame(width: layout.size.width, height: layout.size.height)
                    .clipShape(layout.shape)
                    .overlay(alignment: .topLeading) {
                        if item.isLive {
                            LiveBadgeView().padding(8)
                        }
                    }

                Text(item.title)
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
            }
            .frame(width: layout.size.width)
        }
        .tileButtonStyle()
    }
}

#Preview {
    NavigationStack {
        HStack {
            MediaTileView(item: SampleContent.bigBuckBunny, layout: .poster)
            MediaTileView(item: SampleContent.liveChannelOne, layout: .landscape)
            MediaTileView(item: SampleContent.hosts[0], layout: .circle)
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
