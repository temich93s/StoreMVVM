// Product.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Товар со скидкой
struct Product: Codable {
    /// Категория товара
    let category: String?
    /// Наименование товара
    let name: String?
    /// Цена товара
    let price: Double?
    /// Процент скидки на товар
    let discount: Int?
    /// Ссылка по которому храниться изображение
    let imageURL: String?
    /// Изображение товара
    var imageData: Data?

    enum CodingKeys: String, CodingKey {
        case category, name, price, discount, imageData
        case imageURL = "image_url"
    }
}
