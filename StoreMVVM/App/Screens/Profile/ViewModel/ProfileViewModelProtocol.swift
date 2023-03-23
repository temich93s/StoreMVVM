// ProfileViewModelProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол вью модели экрана регистрации
protocol ProfileViewModelProtocol: ObservableObject {
    var menuItems: [MenuItem] { get set }
    var selectedPhotosPickerData: Data? { get set }
}
