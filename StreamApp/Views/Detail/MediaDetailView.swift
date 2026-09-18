//
//  MediaDetailView.swift
//  StreamApp
//
//  Details for one catalog item. Playable items get a Play button; host
//  profiles show a portrait and a short bio instead.
//

import SwiftUI

struct MediaDetailView: View {
    let item: MediaItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                header

                VStack(alignment: .leading, spacing: 12) {
                    Text(item.title)
                        .font(.largeTitle.bold())
                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    if let stream = item.stream {
                        NavigationLink(value: AppRoute.player(stream)) {
                            Label("Play", systemImage: "play.fill")
                                .frame(maxWidth: 320)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.vertical, 4)
                    }

                    Text(item.overview)
                        .font(.body)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 40)
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle(item.title)
        #if !os(tvOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    @ViewBuilder
    private var header: some View {
        if item.isPlayable {
            ArtworkImageView(
                artwork: item.artwork,
                title: item.title,
                requestSize: CGSize(width: 1280, height: 720)
            )
            .frame(height: LayoutMetrics.detailBackdropHeight)
            .frame(maxWidth: .infinity)
            .clipped()
            .overlay(alignment: .topLeading) {
                if item.isLive {
                    LiveBadgeView().padding()
                }
            }
        } else {
            let side = LayoutMetrics.profilePortraitSize
            ArtworkImageView(
                artwork: item.artwork,
                title: item.title,
                requestSize: CGSize(width: side, height: side)
            )
            .frame(width: side, height: side)
            .clipShape(Circle())
            .frame(maxWidth: .infinity)
            .padding(.top, 24)
        }
    }
}

#Preview("Movie") {
    NavigationStack {
        MediaDetailView(item: SampleContent.bigBuckBunny)
    }
    .preferredColorScheme(.dark)
}

#Preview("Host") {
    NavigationStack {
        MediaDetailView(item: SampleContent.hosts[0])
    }
    .preferredColorScheme(.dark)
}
