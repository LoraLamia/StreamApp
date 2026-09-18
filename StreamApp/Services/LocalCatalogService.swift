//
//  LocalCatalogService.swift
//  StreamApp
//
//  Stands in for a backend. Returns a hardcoded catalog built from public
//  HLS test streams so the browsing UI can be tried on iOS and tvOS.
//

struct LocalCatalogService: CatalogService {
    func loadCatalog() async throws -> Catalog {
        Catalog(featured: SampleContent.tearsOfSteel, sections: SampleContent.sections)
    }
}
