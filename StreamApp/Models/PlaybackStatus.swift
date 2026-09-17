//
//  PlaybackStatus.swift
//  StreamApp
//

enum PlaybackStatus: Equatable {
    case loading
    case ready
    case failed(message: String)
}
