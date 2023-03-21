// ViewName.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Список экранов
enum ViewName: String, Identifiable {
    case logIn, signIn, mainMenu

    var id: String {
        rawValue
    }
}
