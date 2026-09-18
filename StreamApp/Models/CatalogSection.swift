//
//  CatalogSection.swift
//  StreamApp
//

import Foundation

/// A titled row on the home screen, e.g. "Trending Now".
struct CatalogSection: Identifiable, Hashable {
    let id: String
    let title: String
    let layout: TileLayout
    let items: [MediaItem]
}
