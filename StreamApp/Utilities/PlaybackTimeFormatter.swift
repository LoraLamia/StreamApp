//
//  PlaybackTimeFormatter.swift
//  StreamApp
//

import Foundation

enum PlaybackTimeFormatter {
    /// Formats seconds as `m:ss`, or `h:mm:ss` once the value reaches an hour.
    static func string(from seconds: TimeInterval) -> String {
        guard seconds.isFinite, seconds >= 0 else { return "--:--" }
        let pattern: Duration.TimeFormatStyle.Pattern = seconds >= 3600 ? .hourMinuteSecond : .minuteSecond
        return Duration.seconds(seconds).formatted(.time(pattern: pattern))
    }
}
