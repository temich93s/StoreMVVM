// CoordinatorView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Вью координатора приложения
struct CoordinatorView: View {
    // MARK: - Public Properties

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(viewName: .signIn)
                .navigationDestination(for: ViewName.self) { viewName in
                    coordinator.build(viewName: viewName)
                }
        }
        .environmentObject(coordinator)
    }

    // MARK: - Private Properties

    @StateObject private var coordinator = Coordinator()
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView()
    }
}
