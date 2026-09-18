//
//  HeroBannerView.swift
//  StreamApp
//
//  Large featured item at the top of the home screen with Play and
//  More Info actions.
//

import SwiftUI

struct HeroBannerView: View {
    let item: MediaItem

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ArtworkImageView(
                artwork: item.artwork,
                title: item.title,
                requestSize: CGSize(width: 1280, height: 720)
            )
            .frame(height: LayoutMetrics.heroHeight)
            .frame(maxWidth: .infinity)
            .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.7), .black],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 12) {
                Text(item.title)
                    .font(.largeTitle.bold())
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(item.overview)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)

                HStack(spacing: 16) {
                    if let stream = item.stream {
                        NavigationLink(value: AppRoute.player(stream)) {
                            Label("Play", systemImage: "play.fill")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    NavigationLink(value: AppRoute.detail(item)) {
                        Label("More Info", systemImage: "info.circle")
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.top, 4)
            }
            .padding()
        }
        .frame(height: LayoutMetrics.heroHeight)
    }
}

#Preview {
    NavigationStack {
        HeroBannerView(item: SampleContent.tearsOfSteel)
    }
    .preferredColorScheme(.dark)
}
