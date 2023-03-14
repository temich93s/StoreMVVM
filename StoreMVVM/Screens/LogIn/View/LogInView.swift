// LogInView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

// Экран входа
struct LogInView: View {
    // MARK: - Public Methods

    var body: some View {
        ZStack {
            Color("BackgroundMainViewColor")
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 100)
                    .border(.green)
                Text("Welcome back")
                    .font(Font.custom("Montserrat-Bold", size: 26))
                Spacer()
                    .frame(height: 100)
                TextField("First name", text: $firstNameText)
                    .roundedGrayStyle()
                Spacer()
                    .frame(height: 30)
                ZStack {
                    TextField("Password", text: $firstNameText)
                        .roundedGrayStyle()
                    HStack {
                        Spacer()
                        Button(action: {
                            print("button pressed")
                        }, label: {
                            Image("EyeSlash")
                                .renderingMode(.original)
                        })
                        Spacer()
                            .frame(width: 15)
                    }
                }

                Spacer()
                    .frame(height: 100)
                    .border(.green)
                Button("Login") {}
                    .roundedBlueStyle()
                Spacer()
            }
            .frame(width: 290)
        }
    }

    // MARK: - Private Properties

    @State private var firstNameText = ""
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
