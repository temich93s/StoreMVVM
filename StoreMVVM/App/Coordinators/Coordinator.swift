// Coordinator.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Координатор приложения
class Coordinator: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ viewName: ViewName) {
        path.append(viewName)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    @ViewBuilder
    func build(viewName: ViewName) -> some View {
        switch viewName {
        case .logIn:
            LogInView()
        case .signIn:
            SignInView()
        }
    }
}
