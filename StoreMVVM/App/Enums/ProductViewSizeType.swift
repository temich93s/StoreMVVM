// ProductViewSizeType.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Типы размеров View продукта
enum ProductViewSizeType {
    /// Средний размер
    case medium
    /// Большой размер
    case large

    // MARK: - Public Methods

    var frameWidth: CGFloat {
        switch self {
        case .medium:
            return 115
        case .large:
            return 175
        }
    }

    var frameHeight: CGFloat {
        switch self {
        case .medium:
            return 150
        case .large:
            return 220
        }
    }

    var darkHeartButtonDiameter: CGFloat {
        switch self {
        case .medium:
            return 0
        case .large:
            return 28
        }
    }

    var plusButtonDiameter: CGFloat {
        switch self {
        case .medium:
            return 20
        case .large:
            return 35
        }
    }
}
