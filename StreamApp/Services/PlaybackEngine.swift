//
//  PlaybackEngine.swift
//  StreamApp
//

import AVFoundation

protocol PlaybackEngine: AnyObject {
    /// Exposed only so a rendering surface can attach to it.
    var player: AVPlayer { get }

    var status: PlaybackStatus { get }
    var isPlaying: Bool { get }
    var isBuffering: Bool { get }
    var currentTime: TimeInterval { get }
    var duration: TimeInterval { get }
    var rate: Float { get }

    func load(url: URL)
    func play()
    func pause()
    func seek(to seconds: TimeInterval)
    func setRate(_ rate: Float)
}
