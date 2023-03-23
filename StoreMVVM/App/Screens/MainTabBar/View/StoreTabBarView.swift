// StoreTabBarView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Кастомный таббар
struct StoreTabBarView: View {
    // MARK: - Public Properties

    var selection: Int

    var body: some View {
        ZStack {
            Color.clear
            StoreBackgroundTabBarShape(cornerRadius: 28)
                .fill(Color(NameColors.tabBarBackgroundColor))
            tabsView
        }
        .frame(height: 70)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Color.clear
                .frame(height: 0)
                .background(Color(NameColors.tabBarBackgroundColor))
        }
    }

    // MARK: - Private Properties

    private let tabBarImageNames = [
        TabItem(iconName: NameImages.home),
        TabItem(iconName: NameImages.heart),
        TabItem(iconName: NameImages.basket),
        TabItem(iconName: NameImages.message),
        TabItem(iconName: NameImages.profile)
    ]

    @EnvironmentObject private var coordinator: Coordinator

    @Namespace private var tabBarItem

    private var tabsView: some View {
        HStack {
            ForEach(0 ..< tabBarImageNames.count) { index in
                Button(action: {
                    coordinator.pushFromTabBar(index: index)
                }, label: {
                    HStack {
                        Spacer()
                        ZStack {
                            if selection == index {
                                Circle()
                                    .fill(Color(NameColors.lightGrayCircleColor))
                                    .frame(width: 40)
                            }
                            Image(tabBarImageNames[index].iconName)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        Spacer()
                    }
                })
            }
        }
    }
}

struct StoreTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        StoreTabBarView(selection: 1)
    }
}
