// MainTabBarView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Главный таббар приложения
struct MainTabBarView: View {
    // MARK: - Constants

    private enum Constants {
        static var emptyText = ""
    }

    // MARK: - Public Properties

    var body: some View {
        ZStack {
            if selection == 0 {
                // SettingsView(showTabBar: $showTabBar)
                Text(Constants.emptyText)
            } else if selection == 1 {
                Text(Constants.emptyText)
            } else if selection == 2 {
                Text(Constants.emptyText)
            } else if selection == 3 {
                Text(Constants.emptyText)
            } else if selection == 4 {
                ProfileView()
            }
            if showTabBar {
                StoreTabBarView(selection: $selection)
            }
        }
        // .environmentObject(climateViewModel)
    }

    // MARK: - Private Properties

    // @StateObject private var climateViewModel = ClimateViewModel()

    @State private var showTabBar = true
    @State private var selection = 0
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}
