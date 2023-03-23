// CoreDataService.swift
// Copyright © SolovevAA. All rights reserved.

import CoreData
import Foundation

/// Сервис для работы с CoreData
final class CoreDataService: ObservableObject {
    // MARK: - Public Properties

    var container = NSPersistentContainer(name: Constants.persistentContainerName)

    // MARK: - Initializers

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error)
            }
        }
    }
}
