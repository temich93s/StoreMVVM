// QueryType.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Типы тел сетевых запросов
enum QueryType: String {
    /// Последние покупки пользователя
    case latest = "cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
    /// Распродажи
    case flashSale = "a9ceeb6e-416d-4352-bde6-2203416576ac"
    /// Описание продукта
    case productDetail = "f7f99d04-4971-45d5-92e0-70333383c239"
    /// Список товаров по запросу пользователя
    case listWords = "4c9cd822-9479-4509-803d-63197e5a9e19"
}
