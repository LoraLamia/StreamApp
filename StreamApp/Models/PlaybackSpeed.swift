//
//  PlaybackSpeed.swift
//  StreamApp
//

import Foundation

enum PlaybackSpeed: Float, CaseIterable, Identifiable {
    case half = 0.5
    case normal = 1.0
    case fast = 1.5
    case double = 2.0

    var id: Float { rawValue }

    var label: String {
        rawValue.formatted(.number.precision(.fractionLength(0...1))) + "×"
    }
}
