//
//  Artwork.swift
//  StreamApp
//

import Foundation

/// Where a tile or backdrop image comes from.
enum Artwork: Hashable {
    /// Deterministic sample photo from picsum.photos. The same seed always
    /// returns the same picture, cropped to whatever size is requested.
    case sample(seed: String)
    /// A fixed image URL.
    case remote(URL)

    /// Image URL for the given point size. Sample images are requested at 2x
    /// so they stay sharp on Retina displays.
    func url(fitting size: CGSize) -> URL {
        switch self {
        case .remote(let url):
            return url
        case .sample(let seed):
            let width = Int(size.width * 2)
            let height = Int(size.height * 2)
            return URL(string: "https://picsum.photos/seed/\(seed)/\(width)/\(height)")!
        }
    }
}
