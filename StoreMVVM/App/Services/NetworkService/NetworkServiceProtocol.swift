// NetworkServiceProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол сетевого сервиса
protocol NetworkServiceProtocol {
    func fetchProductData(queryType: QueryType, completion: @escaping (Result<[Product], Error>) -> Void)
    func fetchProductDetailData(queryType: QueryType, completion: @escaping (Result<ProductDetail, Error>) -> Void)
    func fetchListWordsData(queryType: QueryType, completion: @escaping (Result<[String], Error>) -> Void)
}
