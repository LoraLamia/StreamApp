//
//  MediaItem.swift
//  StreamApp
//

import Foundation

/// One entry in the catalog: a movie, a live channel or an image-only profile.
struct MediaItem: Identifiable, Hashable {
    let id: String
    let title: String
    /// Short metadata line, e.g. "Animation · 2008 · 10 min".
    let subtitle: String
    let overview: String
    let artwork: Artwork
    /// nil for items that have no video, such as host profiles.
    let stream: Stream?

    var isPlayable: Bool { stream != nil }
    var isLive: Bool { stream?.isLive ?? false }
}
