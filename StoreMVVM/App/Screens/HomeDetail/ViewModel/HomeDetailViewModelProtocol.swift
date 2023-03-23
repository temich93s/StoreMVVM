// HomeDetailViewModelProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол вью модели экрана c описанием продукта
protocol HomeDetailViewModelProtocol: ObservableObject {
    var productDetail: ProductDetail? { get set }
    var productCount: Int { get set }
    var selectedColorIndex: Int { get set }
    var selectedImageIndex: Int { get set }

    func fetchData()
    func increaseProductCount()
    func decreaseProductCount()
    func setupColorIndex(index: Int)
    func setupImageIndex(index: Int)
    func rightSwipeAction()
    func leftSwipeAction()
}
