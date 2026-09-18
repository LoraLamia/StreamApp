//
//  ArtworkImageView.swift
//  StreamApp
//
//  Loads remote artwork and falls back to a gradient with the title, so
//  tiles never look broken while loading or offline. The caller decides the
//  final frame and clip shape.
//

import SwiftUI

struct ArtworkImageView: View {
    let artwork: Artwork
    let title: String
    /// Point size the image will be shown at; used to request a fitting file.
    let requestSize: CGSize

    var body: some View {
        // Color.clear takes exactly the size the parent proposes. The image is
        // drawn as an overlay so a "fill" image that is wider than the frame
        // overflows and gets clipped instead of stretching the whole layout.
        Color.clear
            .overlay {
                AsyncImage(url: artwork.url(fitting: requestSize)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        placeholder(showsTitle: true)
                    default:
                        placeholder(showsTitle: false)
                    }
                }
            }
            .clipped()
    }

    private func placeholder(showsTitle: Bool) -> some View {
        LinearGradient(
            colors: [Color(white: 0.28), Color(white: 0.12)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay {
            if showsTitle {
                Text(title)
                    .font(.caption.bold())
                    .multilineTextAlignment(.center)
                    .padding(8)
            }
        }
    }
}

#Preview {
    ArtworkImageView(artwork: .sample(seed: "preview"), title: "Preview", requestSize: CGSize(width: 220, height: 124))
        .frame(width: 220, height: 124)
        .clipShape(.rect(cornerRadius: 10))
}
