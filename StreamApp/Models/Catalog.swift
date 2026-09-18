//
//  Catalog.swift
//  StreamApp
//

import Foundation

/// Everything the home screen shows: one featured item for the hero banner
/// and the rows below it.
struct Catalog: Hashable {
    let featured: MediaItem
    let sections: [CatalogSection]
}
