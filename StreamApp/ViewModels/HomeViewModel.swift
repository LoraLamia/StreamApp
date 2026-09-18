//
//  HomeViewModel.swift
//  StreamApp
//
//  Loads the catalog for the home screen and exposes its loading state.
//

import Foundation
import Observation

@Observable
final class HomeViewModel {

    enum LoadState: Equatable {
        case loading
        case loaded(Catalog)
        case failed(String)
    }

    private(set) var state: LoadState = .loading

    private let catalogService: any CatalogService

    init(catalogService: any CatalogService = LocalCatalogService()) {
        self.catalogService = catalogService
    }

    func load() async {
        // Coming back from a pushed screen must not reload and flash the UI.
        if case .loaded = state { return }

        state = .loading
        do {
            state = .loaded(try await catalogService.loadCatalog())
        } catch {
            state = .failed(error.localizedDescription)
        }
    }

    func retry() async {
        state = .loading
        await load()
    }
}
