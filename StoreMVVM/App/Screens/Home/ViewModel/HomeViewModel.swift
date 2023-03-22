// HomeViewModel.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Вью модель экрана регистрации
final class HomeViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var flashSales: [Product] = []
    @Published var lastDeals: [Product] = []
    @Published var brands: [Product] = []

    var networkService = NetworkService()

    // MARK: - Private Properties

    private let fetchGroup = DispatchGroup()

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

    func fetchData() {
        fetchData(queryType: .flashSale)
        fetchData(queryType: .latest)
        fetchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.brands = self.mockBrands
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
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
