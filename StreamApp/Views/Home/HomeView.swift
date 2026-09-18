//
//  HomeView.swift
//  StreamApp
//
//  Root screen. Owns the navigation stack and shows the catalog once it has
//  loaded.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.ignoresSafeArea())
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .detail(let item):
                        MediaDetailView(item: item)
                    case .player(let stream):
                        StreamPlayerView(stream: stream)
                    }
                }
                #if os(iOS)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("STREAMAPP")
                            .font(.headline.bold())
                            .kerning(2)
                            .foregroundStyle(Color.accentColor)
                    }
                }
                .toolbarBackground(.hidden, for: .navigationBar)
                #endif
        }
        .task {
            await viewModel.load()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading catalog…")
        case .failed(let message):
            ContentUnavailableView {
                Label("Couldn't load catalog", systemImage: "exclamationmark.triangle")
            } description: {
                Text(message)
            } actions: {
                Button("Retry") {
                    Task { await viewModel.retry() }
                }
                .buttonStyle(.borderedProminent)
            }
        case .loaded(let catalog):
            CatalogView(catalog: catalog)
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
