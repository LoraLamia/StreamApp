//
//  AVFoundationPlaybackEngine.swift
//  StreamApp
//
//  AVPlayer-backed implementation of PlaybackEngine.
//

import AVFoundation
import Combine
import Observation
import os

private let log = Logger(subsystem: Bundle.main.bundleIdentifier ?? "StreamApp", category: "playback")

@Observable
final class AVFoundationPlaybackEngine: PlaybackEngine {

    let player = AVPlayer()

    private(set) var status: PlaybackStatus = .loading
    private(set) var isPlaying = false
    private(set) var isBuffering = false
    private(set) var currentTime: TimeInterval = 0
    private(set) var duration: TimeInterval = 0
    private(set) var rate: Float = 1.0

    @ObservationIgnored private var timeObserverToken: Any?
    @ObservationIgnored private var playerCancellables = Set<AnyCancellable>()
    @ObservationIgnored private var itemCancellables = Set<AnyCancellable>()

    init() {
        configureAudioSession()
        addPeriodicTimeObserver()
        observePlayer()
    }

    isolated deinit {
        if let timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
        }
    }

    // MARK: - PlaybackEngine

    func load(url: URL) {
        itemCancellables.removeAll()

        status = .loading
        currentTime = 0
        duration = 0

        let item = AVPlayerItem(url: url)
        observe(item: item)
        player.replaceCurrentItem(with: item)
    }

    func play() {
        player.play()
    }

    func pause() {
        player.pause()
    }

    func seek(to seconds: TimeInterval) {
        let upperBound = duration > 0 ? duration : seconds
        let clamped = min(max(seconds, 0), upperBound)
        currentTime = clamped
        player.seek(
            to: CMTime(seconds: clamped, preferredTimescale: 600),
            toleranceBefore: .zero,
            toleranceAfter: .zero
        )
    }

    func setRate(_ newRate: Float) {
        rate = newRate
        player.defaultRate = newRate
        if isPlaying {
            player.rate = newRate
        }
    }

    // MARK: - Observation

    private func configureAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
    }

    private func addPeriodicTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: 600)
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            MainActor.assumeIsolated {
                guard time.isNumeric else { return }
                self?.currentTime = time.seconds
            }
        }
    }

    private func observePlayer() {
        player.publisher(for: \.timeControlStatus)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] timeControlStatus in
                log.debug("timeControlStatus -> \(timeControlStatus.rawValue, privacy: .public)")
                self?.isPlaying = timeControlStatus == .playing
                self?.isBuffering = timeControlStatus == .waitingToPlayAtSpecifiedRate
            }
            .store(in: &playerCancellables)
    }

    private func observe(item: AVPlayerItem) {
        item.publisher(for: \.status)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] itemStatus in
                guard let self else { return }
                switch itemStatus {
                case .readyToPlay:
                    log.notice("item ready to play")
                    status = .ready
                case .failed:
                    let message = item.error?.localizedDescription ?? "Unknown error"
                    log.error("item failed: \(message, privacy: .public)")
                    status = .failed(message: message)
                case .unknown:
                    status = .loading
                @unknown default:
                    break
                }
            }
            .store(in: &itemCancellables)

        item.publisher(for: \.duration)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] itemDuration in
                self?.duration = itemDuration.isNumeric ? itemDuration.seconds : 0
            }
            .store(in: &itemCancellables)
    }
}
