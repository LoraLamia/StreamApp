//
//  CatalogView.swift
//  StreamApp
//
//  Scrolling home content: hero banner followed by one row per section.
//

import SwiftUI

struct CatalogView: View {
    let catalog: Catalog

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: LayoutMetrics.rowSpacing) {
                HeroBannerView(item: catalog.featured)

                ForEach(catalog.sections) { section in
                    CatalogRowView(section: section)
                }
            }
            .padding(.bottom, 40)
        }
        #if os(iOS)
        // Let the hero artwork run under the transparent navigation bar.
        .ignoresSafeArea(edges: .top)
        #endif
    }
}

#Preview {
    NavigationStack {
        CatalogView(catalog: Catalog(featured: SampleContent.tearsOfSteel, sections: SampleContent.sections))
    }
    .preferredColorScheme(.dark)
}
