// FlashSale.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Товар со скидкой
struct FlashSale {
    let id = UUID()
    let category: String
    let name: String
    let price: Int
    let discount: Float
    let imageUrl: String
}

let mockFlashSale = [
    FlashSale(
        category: "GamesGames1",
        name: "Profile Image Mock 1",
        price: 1000,
        discount: 30,
        imageUrl: "ProfileImageMock"
    ),
    FlashSale(
        category: "GamesGames2",
        name: "Profile Image Mock 2",
        price: 2000,
        discount: 40,
        imageUrl: "ProfileImageMock"
    ),
    FlashSale(
        category: "GamesGames3",
        name: "Profile Image Mock 3",
        price: 3000,
        discount: 50,
        imageUrl: "ProfileImageMock"
    ),
    FlashSale(
        category: "GamesGames4",
        name: "Profile Image Mock 4",
        price: 4000,
        discount: 60,
        imageUrl: "ProfileImageMock"
    )
]
