// MenuType.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Типы меню на экране профиля
enum MenuType {
    /// Меню с переходом на другой экран
    case link
    /// Меню без какой либо информации и без перехода
    case empty
    /// Меню с отображением баланса
    case balance(Int)
}
