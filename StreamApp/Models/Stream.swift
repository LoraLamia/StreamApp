//
//  Stream.swift
//  StreamApp
//

import Foundation

struct Stream {
    let title: String
    let url: URL
}

extension Stream {
    static let bigBuckBunny = Stream(
        title: "Big Buck Bunny",
        url: URL(string: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8")!
    )
}
