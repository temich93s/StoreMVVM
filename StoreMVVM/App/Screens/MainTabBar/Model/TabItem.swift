// TabItem.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Cтруктура для таббара
struct TabItem: Identifiable, Equatable {
    /// Идентификатор
    var id = UUID()
    /// Иконка
    var iconName: String
}
