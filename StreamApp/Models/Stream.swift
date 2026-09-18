//
//  Stream.swift
//  StreamApp
//

import Foundation

/// A playable HLS source.
struct Stream: Hashable {
    let title: String
    let url: URL
    /// Live streams have no fixed duration, so the scrubber is disabled.
    var isLive = false
}
