//
//  TileLayout.swift
//  StreamApp
//

import SwiftUI

/// How a catalog row draws its tiles. Sizes are larger on tvOS because the
/// viewer sits far from the screen.
enum TileLayout: Hashable {
    case landscape
    case poster
    case circle

    var size: CGSize {
        #if os(tvOS)
        switch self {
        case .landscape: CGSize(width: 400, height: 225)
        case .poster: CGSize(width: 240, height: 360)
        case .circle: CGSize(width: 200, height: 200)
        }
        #else
        switch self {
        case .landscape: CGSize(width: 220, height: 124)
        case .poster: CGSize(width: 124, height: 186)
        case .circle: CGSize(width: 104, height: 104)
        }
        #endif
    }

    var shape: AnyShape {
        switch self {
        case .circle: AnyShape(Circle())
        case .landscape, .poster: AnyShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
