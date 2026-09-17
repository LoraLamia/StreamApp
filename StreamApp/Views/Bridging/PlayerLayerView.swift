//
//  PlayerLayerView.swift
//  StreamApp
//
//  SwiftUI wrapper around PlayerUIView. Renders AVPlayer output
//  without the system controls so the app can draw its own.
//

import AVFoundation
import SwiftUI

struct PlayerLayerView: UIViewRepresentable {
    let player: AVPlayer

    func makeUIView(context: Context) -> PlayerUIView {
        PlayerUIView()
    }

    func updateUIView(_ uiView: PlayerUIView, context: Context) {
        if uiView.playerLayer.player !== player {
            uiView.playerLayer.player = player
        }
    }
}
