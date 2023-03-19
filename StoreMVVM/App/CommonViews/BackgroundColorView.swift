// BackgroundColorView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Фон основного меню
struct BackgroundColorView: View {
    var body: some View {
        Color("BackgroundMainViewColor")
            .ignoresSafeArea()
    }
}

struct BackgroundColorView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundColorView()
    }
}
