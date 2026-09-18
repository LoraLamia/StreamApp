//
//  LayoutMetrics.swift
//  StreamApp
//
//  Spacing and sizes that differ between a phone in the hand and a TV
//  across the room. Kept in one place so views stay free of #if noise.
//

import CoreGraphics

enum LayoutMetrics {
    #if os(tvOS)
    static let heroHeight: CGFloat = 640
    static let detailBackdropHeight: CGFloat = 520
    static let profilePortraitSize: CGFloat = 320
    static let rowSpacing: CGFloat = 48
    static let tileSpacing: CGFloat = 40
    /// Extra vertical room so a focused, enlarged tile is not clipped.
    static let rowFocusInset: CGFloat = 40
    #else
    static let heroHeight: CGFloat = 460
    static let detailBackdropHeight: CGFloat = 240
    static let profilePortraitSize: CGFloat = 180
    static let rowSpacing: CGFloat = 24
    static let tileSpacing: CGFloat = 12
    static let rowFocusInset: CGFloat = 0
    #endif
}
