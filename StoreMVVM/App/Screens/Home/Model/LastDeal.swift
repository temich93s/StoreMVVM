// LastDeal.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Последний приобретенный товар пользователем
struct LastDeal {
    let id = UUID()
    let category: String
    let name: String
    let price: Int
    let imageUrl: String
}

let mockLastDeals = [
    LastDeal(category: "GamesGames1", name: "Profile Image Mock 1", price: 1000, imageUrl: "ProfileImageMock"),
    LastDeal(category: "Games2", name: "Profile Image Mock 1", price: 2000, imageUrl: "ProfileImageMock"),
    LastDeal(category: "Games3", name: "Profile Image Mock 1", price: 3000, imageUrl: "ProfileImageMock"),
    LastDeal(category: "Games4", name: "Profile Image Mock 1", price: 4000, imageUrl: "ProfileImageMock"),
]
