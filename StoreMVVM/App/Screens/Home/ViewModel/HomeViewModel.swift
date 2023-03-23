// HomeViewModel.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Вью модель экрана регистрации
final class HomeViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var flashSales: [Product] = []
    @Published var lastDeals: [Product] = []
    @Published var brands: [Product] = []
    @Published var searchText = ""
    @Published var listWords: [String] = []

    var networkService = NetworkService()

    // MARK: - Private Properties

    private let fetchGroup = DispatchGroup()
    private var timer = Timer()

    private let mockBrands = [
        Product(
            category: "Phones",
            name: "Samsung Galaxy S9",
            price: 80,
            discount: nil,
            imageURL: nil,
            imageData: UIImage(named: "Samsung")?.pngData()
        ),
        Product(
            category: "Games",
            name: "Play Station 4 Console",
            price: 100,
            discount: nil,
            imageURL: nil,
            imageData: UIImage(named: "PS4")?.pngData()
        ),
        Product(
            category: "Games",
            name: "Play Station 4 Gamepad",
            price: 20,
            discount: nil,
            imageURL: nil,
            imageData: UIImage(named: "PS4Gamepad")?.pngData()
        )
    ]

    // MARK: - Public Methods

    func fetchProductData() {
        fetchData(queryType: .flashSale)
        fetchData(queryType: .latest)
        fetchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.brands = self.mockBrands
        }
    }

    func fetchListWordsData(action: @escaping ([String]) -> ()) {
        networkService.fetchListWordsData(queryType: .listWords) { result in
            switch result {
            case let .success(data):
                action(data)
            case let .failure(error):
                print(error)
            }
        }
    }

    func deferredSearchTextAction(text: String) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.searchTextAction(text: text)
        }
    }

    func searchTextAction(text: String) {
        fetchListWordsData { result in
            let searchText = result.filter { $0.range(of: text, options: .caseInsensitive) != nil }
            DispatchQueue.main.async {
                self.listWords = searchText
                print(self.listWords)
            }
        }
    }

    // MARK: - Private Methods

    private func fetchData(queryType: QueryType) {
        fetchGroup.enter()
        networkService.fetchProductData(queryType: queryType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.fetchGroup.leave()
                self.fetchGroup.notify(queue: .main) {
                    switch queryType {
                    case .flashSale:
                        self.flashSales = data
                    case .latest:
                        self.lastDeals = data
                    default:
                        break
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
