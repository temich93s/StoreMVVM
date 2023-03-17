// CoreDataService.swift
// Copyright © SolovevAA. All rights reserved.

import CoreData
import Foundation

/// Сервис для работы с CoreData
class CoreDataService: ObservableObject {
    var container = NSPersistentContainer(name: "CoreDataUserModel")

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
