//
//  View+TileButtonStyle.swift
//  StreamApp
//

import SwiftUI

extension View {
    /// Netflix-style tile interaction. On tvOS the system card style lifts
    /// and shadows the tile when it has focus; on iOS a plain style keeps the
    /// artwork untinted.
    func tileButtonStyle() -> some View {
        #if os(tvOS)
        buttonStyle(.card)
        #else
        buttonStyle(.plain)
        #endif
    }
}
