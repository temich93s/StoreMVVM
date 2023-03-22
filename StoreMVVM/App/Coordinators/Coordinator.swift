// Coordinator.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Координатор приложения
class Coordinator: ObservableObject {
    // MARK: - Constants

    private enum Constants {
        static var emptyText = ""
    }

    @Published var path = NavigationPath()

    func setupTabBar(index: Int) {
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
            LogInView()
        case .signIn:
            SignInView()
        case .homeDetail:
            ZStack {
                BackgroundColorView()
                HomeDetailView()
                VStack {
                    Spacer()
                    StoreTabBarView(selection: 0)
                }
            }
            .toolbar(.hidden)
        case .home:
            ZStack {
                BackgroundColorView()
                VStack {
                    HomeView()
                    Spacer()
                    StoreTabBarView(selection: 0)
                }
            }
            .toolbar(.hidden)
        case .heart:
            ZStack {
                BackgroundColorView()
                VStack {
                    Text(Constants.emptyText)
                    Spacer()
                    StoreTabBarView(selection: 1)
                }
            }
            .toolbar(.hidden)
        case .basket:
            ZStack {
                BackgroundColorView()
                VStack {
                    Text(Constants.emptyText)
                    Spacer()
                    StoreTabBarView(selection: 2)
                }
            }
            .toolbar(.hidden)
        case .message:
            ZStack {
                BackgroundColorView()
                VStack {
                    Text(Constants.emptyText)
                    Spacer()
                    StoreTabBarView(selection: 3)
                }
            }
            .toolbar(.hidden)
        case .profile:
            ZStack {
                BackgroundColorView()
                VStack {
                    ProfileView()
                    Spacer()
                    StoreTabBarView(selection: 4)
                }
            }
            .toolbar(.hidden)
        }
    }
}
