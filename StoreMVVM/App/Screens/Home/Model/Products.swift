// Products.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Товары
struct Products: Codable {
    /// Товары со скидкой
    let flashSale: [Product]?
    /// Последние приобретенные товары пользователем
    let latest: [Product]?

    enum CodingKeys: String, CodingKey {
        case latest
        case flashSale = "flash_sale"
    }
}
