// Coordinator.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Координатор приложения
class Coordinator: ObservableObject {
    // MARK: - Public Properties

    @Published var path = NavigationPath()

    // MARK: - Public Properties

    private let builder = Builder()

    // MARK: - Public Methods

    func pushFromTabBar(index: Int) {
        switch index {
        case 0:
            path.removeLast()
            push(.home)
        case 1:
            path.removeLast()
            push(.heart)
        case 2:
            path.removeLast()
            push(.basket)
        case 3:
            path.removeLast()
            push(.message)
        case 4:
            path.removeLast()
            push(.profile)
        default:
            break
        }
    }

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
            builder.makeLogInView()
        case .signIn:
            builder.makeSignInView()
        case .homeDetail:
            builder.makeHomeDetailView(tabBarSelection: 0)
        case .addToCard:
            builder.makeAddToCardView(tabBarSelection: 0)
        case .home:
            builder.makeHomeView(tabBarSelection: 0)
        case .heart:
            builder.makeHeartView(tabBarSelection: 1)
        case .basket:
            builder.makeBasketView(tabBarSelection: 2)
        case .message:
            builder.makeMessageView(tabBarSelection: 3)
        case .profile:
            builder.makeProfileView(tabBarSelection: 4)
        }
    }
}
