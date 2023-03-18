// StoreTabBarView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Кастомный таббар в дизайне теслы
struct StoreTabBarView: View {
    // MARK: - Constants

    private enum Constants {
        static var matchedGeometryEffectIdText = "tabBarItem"
    }

    // MARK: - Public Properties

    @Binding var selection: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                ZStack {
                    StoreBackgroundTabBarShape(cornerRadius: 28)
                        .fill(Color("TabBarBackgroundColor"))
                    tabsView
                }
                .frame(width: UIScreen.main.bounds.width, height: 70)
            }
        }
    }

    // MARK: - Private Properties

    @Namespace private var tabBarItem

    private let tabBarImageNames = [
        TabItem(iconName: "Home"),
        TabItem(iconName: "Heart"),
        TabItem(iconName: "Basket"),
        TabItem(iconName: "Message"),
        TabItem(iconName: "Profile")
    ]

    private var tabsView: some View {
        HStack {
            ForEach(0 ..< tabBarImageNames.count) { index in
                HStack {
                    Button(action: {
                        selection = index
                    }, label: {
                        HStack {
                            Spacer()
                            ZStack {
                                if selection == index {
                                    Circle()
                                        .fill(Color("TabBarCircleColor"))
                                        .frame(width: 40)
                                }
                                Image(tabBarImageNames[index].iconName)
                                    .font(.system(size: 22))
                            }
                            Spacer()
                        }
                    })
                }
            }
        }
    }
}

struct StoreTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        StoreTabBarView(selection: .constant(1))
    }
}
