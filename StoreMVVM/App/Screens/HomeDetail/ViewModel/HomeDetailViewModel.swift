// HomeDetailViewModel.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Вью модель экрана регистрации
final class HomeDetailViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var productDetail: ProductDetail?

    @Published var productCount = 0

    @Published var selectedColorIndex = 0

    var networkService = NetworkService()

    // MARK: - Public Methods

    func fetchData() {
        networkService.fetchProductDetailData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                DispatchQueue.main.async {
                    self.productDetail = data
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func increaseProductCount() {
        productCount += 1
    }

    func decreaseProductCount() {
        if productCount > 0 {
            productCount -= 1
        }
    }

    func setupColorIndex(index: Int) {
        selectedColorIndex = index
    }
}
