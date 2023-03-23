// HomeViewModelProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол вью модели экрана cо списком продуктов
protocol HomeViewModelProtocol: ObservableObject {
    var flashSales: [Product] { get set }
    var lastDeals: [Product] { get set }
    var brands: [Product] { get set }
    var listWords: [String] { get set }
    var searchText: String { get set }

    func fetchProductData()
    func fetchListWordsData(action: @escaping ([String]) -> ())
    func deferredSearchTextAction(text: String)
    func searchTextAction(text: String)
}
