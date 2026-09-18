//
//  CatalogRowView.swift
//  StreamApp
//
//  A titled, horizontally scrolling row of tiles.
//

import SwiftUI

struct CatalogRowView: View {
    let section: CatalogSection

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(section.title)
                .font(.title3.bold())
                .padding(.horizontal)

            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: LayoutMetrics.tileSpacing) {
                    ForEach(section.items) { item in
                        MediaTileView(item: item, layout: section.layout)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, LayoutMetrics.rowFocusInset)
            }
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }
    }
}

#Preview {
    NavigationStack {
        CatalogRowView(section: SampleContent.sections[0])
    }
    .preferredColorScheme(.dark)
}
