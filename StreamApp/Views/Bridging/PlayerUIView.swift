//
//  PlayerUIView.swift
//  StreamApp
//

import AVFoundation
import UIKit

/// UIView whose backing layer is an AVPlayerLayer.
final class PlayerUIView: UIView {
    override class var layerClass: AnyClass { AVPlayerLayer.self }

    var playerLayer: AVPlayerLayer {
        // Safe: layerClass guarantees the backing layer type.
        layer as! AVPlayerLayer
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        playerLayer.videoGravity = .resizeAspect
        backgroundColor = .black
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("PlayerUIView is created in code only")
    }
}
