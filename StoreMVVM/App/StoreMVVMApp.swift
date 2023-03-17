// StoreMVVMApp.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

@main
struct StoreMVVMApp: App {
    @StateObject private var coreDataService = CoreDataService()

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(\.managedObjectContext, coreDataService.container.viewContext)
        }
    }
}
