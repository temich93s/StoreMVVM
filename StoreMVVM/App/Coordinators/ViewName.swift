// ViewName.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Список экранов
enum ViewName: String, Identifiable {
    case logIn, signIn, home, heart, basket, message, profile, homeDetail, addToCard

    // MARK: - Public Properties

    var id: String {
        rawValue
    }
}
