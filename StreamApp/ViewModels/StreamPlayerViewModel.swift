//
//  StreamPlayerViewModel.swift
//  StreamApp
//
//  Presentation logic for the stream player screen. Views read
//  display-ready values from here and send user intents back.
//

import AVFoundation
import Observation

@Observable
final class StreamPlayerViewModel {

    enum VideoOverlay: Equatable {
        case none
        case loading
        case buffering
        case error(String)
    }

    let stream: Stream

    private let engine: any PlaybackEngine
    private let skipInterval: TimeInterval = 10

    /// Non-nil while the user is dragging the scrubber (iOS) or nudging it
    /// with the remote (tvOS).
    private var scrubPosition: TimeInterval?

    /// How long to wait after the last remote press before seeking.
    private let scrubCommitDelay: Duration = .milliseconds(400)
    @ObservationIgnored private var scrubCommitTask: Task<Void, Never>?

    init(stream: Stream, engine: any PlaybackEngine = AVFoundationPlaybackEngine()) {
        self.stream = stream
        self.engine = engine
    }

    /// Loads the stream and starts playback. The view calls this once when
    /// the player screen appears, so creating the view model has no side
    /// effects.
    func start() {
        engine.load(url: stream.url)
        engine.play()
    }

    // MARK: - Display state

    var title: String { stream.title }
    var sourceDescription: String { stream.url.absoluteString }

    /// Needed by the video surface to attach a rendering layer.
    var player: AVPlayer { engine.player }

    var isReady: Bool { engine.status == .ready }
    var isPlaying: Bool { engine.isPlaying }
    var canScrub: Bool { engine.duration > 0 }

    var sliderRange: ClosedRange<TimeInterval> { 0...max(engine.duration, 1) }
    var currentTimeText: String { PlaybackTimeFormatter.string(from: sliderValue) }
    var durationText: String {
        stream.isLive ? "LIVE" : PlaybackTimeFormatter.string(from: engine.duration)
    }

    var statusDescription: String {
        switch engine.status {
        case .loading: "Loading"
        case .failed: "Failed"
        case .ready where engine.isBuffering: "Buffering"
        case .ready where engine.isPlaying: "Playing"
        case .ready: "Paused"
        }
    }

    var videoOverlay: VideoOverlay {
        switch engine.status {
        case .loading: .loading
        case .failed(let message): .error(message)
        case .ready where engine.isBuffering: .buffering
        case .ready: .none
        }
    }

    // MARK: - Bindable state

    var sliderValue: TimeInterval {
        get { scrubPosition ?? engine.currentTime }
        set { scrubPosition = newValue }
    }

    var selectedSpeed: PlaybackSpeed {
        get { PlaybackSpeed(rawValue: engine.rate) ?? .normal }
        set { engine.setRate(newValue.rawValue) }
    }

    // MARK: - Intents

    func togglePlayPause() {
        if engine.isPlaying {
            engine.pause()
            return
        }
        // Restart from the beginning if playback already reached the end.
        if engine.duration > 0, engine.currentTime >= engine.duration - 0.5 {
            engine.seek(to: 0)
        }
        engine.play()
    }

    func skipBackward() {
        engine.seek(to: engine.currentTime - skipInterval)
    }

    func skipForward() {
        engine.seek(to: engine.currentTime + skipInterval)
    }

    func sliderEditingChanged(_ isEditing: Bool) {
        guard !isEditing, let target = scrubPosition else { return }
        engine.seek(to: target)
        scrubPosition = nil
    }

    // MARK: Remote scrubbing (tvOS)

    func scrubBackward() {
        nudgeScrubPosition(by: -skipInterval)
    }

    func scrubForward() {
        nudgeScrubPosition(by: skipInterval)
    }

    /// Moves the scrub position without seeking yet. The seek happens once
    /// the user stops pressing for `scrubCommitDelay`, so holding a remote
    /// button feels like fast-forward instead of firing a network seek on
    /// every single press.
    private func nudgeScrubPosition(by step: TimeInterval) {
        guard canScrub else { return }
        scrubPosition = min(max(sliderValue + step, 0), engine.duration)

        scrubCommitTask?.cancel()
        scrubCommitTask = Task {
            try? await Task.sleep(for: scrubCommitDelay)
            guard !Task.isCancelled else { return }
            sliderEditingChanged(false)
        }
    }

    func retry() {
        start()
    }
}
