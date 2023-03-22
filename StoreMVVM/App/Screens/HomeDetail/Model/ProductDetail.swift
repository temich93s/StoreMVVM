// ProductDetail.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// ProductDetail
struct ProductDetail: Codable {
    let name: String
    let description: String
    let rating: Double
    let numberOfReviews: Int
    let price: Double
    let colors: [String]
    let imageUrls: [String]
    var imageData: [Data?]?

    enum CodingKeys: String, CodingKey {
        case name, description, rating, imageData
        case numberOfReviews = "number_of_reviews"
        case price, colors
        case imageUrls = "image_urls"
    }
}
