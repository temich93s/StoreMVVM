// Category.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Категории товаров
struct Category {
    /// id товара
    let id = UUID()
    /// Название категории
    let categoryName: String
    /// Название изображения категории
    let categoryImageName: String
}

let mockCategories = [
    Category(categoryName: "Phones", categoryImageName: "Phones"),
    Category(categoryName: "Headphones", categoryImageName: "Headphones"),
    Category(categoryName: "Games", categoryImageName: "Games"),
    Category(categoryName: "Cars", categoryImageName: "Cars"),
    Category(categoryName: "Furniture", categoryImageName: "Furniture"),
    Category(categoryName: "Kids", categoryImageName: "Kids")
]
