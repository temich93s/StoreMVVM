// StoreMVVMApp.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

@main
struct StoreMVVMApp: App {
    // MARK: - Public Properties

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(\.managedObjectContext, coreDataService.container.viewContext)
        }
    }

    // MARK: - Private Properties

    @StateObject private var coreDataService = CoreDataService()
}
