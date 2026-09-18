//
//  AppRoute.swift
//  StreamApp
//

import Foundation

/// Screens that can be pushed onto the home navigation stack.
enum AppRoute: Hashable {
    case detail(MediaItem)
    case player(Stream)
}
