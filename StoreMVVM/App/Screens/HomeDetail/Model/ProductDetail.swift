// ProductDetail.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Описание продукта
struct ProductDetail: Codable {
    /// Наименование продукта
    let name: String
    /// Описание продукта
    let description: String
    /// Рейтинг продукта
    let rating: Double
    /// Количество обзоров продукта
    let numberOfReviews: Int
    /// Цена продукта
    let price: Double
    /// Цвета продукта
    let colors: [String]
    /// Текстовые ссылки по которым хранятся изображения продукта
    let imageUrls: [String]
    /// Изображения продукта
    var imageData: [Data?]?

    // MARK: - Enums

    enum CodingKeys: String, CodingKey {
        case name, description, rating, imageData
        case numberOfReviews = "number_of_reviews"
        case price, colors
        case imageUrls = "image_urls"
    }
}
