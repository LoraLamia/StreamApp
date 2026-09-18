//
//  CatalogService.swift
//  StreamApp
//

protocol CatalogService {
    func loadCatalog() async throws -> Catalog
}
