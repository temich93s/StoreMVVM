// ProfileViewModel.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Вью модель экрана регистрации
final class ProfileViewModel: ProfileViewModelProtocol {
    // MARK: - Public Properties

    @Published var menuItems = [
        MenuItem(menuText: "Trade store", imageName: "Card", menuType: .link),
        MenuItem(menuText: "Payment method", imageName: "Card", menuType: .link),
        MenuItem(menuText: "Balance", imageName: "Card", menuType: .balance(1593)),
        MenuItem(menuText: "Trade history", imageName: "Card", menuType: .link),
        MenuItem(menuText: "Restore purchase", imageName: "Restore", menuType: .link),
        MenuItem(menuText: "Help", imageName: "Help", menuType: .empty),
        MenuItem(menuText: "Log out", imageName: "LogOut", menuType: .empty)
    ]

    @Published var selectedPhotosPickerData: Data?
}
