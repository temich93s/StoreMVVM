// HomeDetailViewModelProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

protocol HomeDetailViewModelProtocol: ObservableObject {
    var productDetail: ProductDetail? { get }
    var productCount: Int { get }
    var selectedColorIndex: Int { get }
    var selectedImageIndex: Int { get }

    func fetchData()
    func increaseProductCount()
    func decreaseProductCount()
    func setupColorIndex(index: Int)
    func setupImageIndex(index: Int)
    func rightSwipeAction()
    func leftSwipeAction()
}
