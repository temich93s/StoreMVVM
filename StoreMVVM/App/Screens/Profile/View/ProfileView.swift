// ProfileView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Экран профиля пользователя
struct ProfileView: View {
    // MARK: - Public Methods

    var body: some View {
        ZStack {
            ZStack {
                Color("BackgroundMainViewColor")
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Button(action: {
                            coordinator.popToRoot()
                        }, label: {
                            Image("Back")
                                .resizable()
                        })
                        .frame(width: 20, height: 20)
                        Spacer()
                        Text("Profile")
                            .font(Font.custom("Montserrat-Bold", size: 20))
                            .foregroundColor(Color("BlackTextColor"))
                        Spacer()
                        Spacer()
                            .frame(width: 20)
                    }
                    .padding(.horizontal)
                    ScrollView {
                        Image("ProfileImageMock")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                            .overlay {
                                Circle()
                                    .stroke(Color("DarkGrayTextColor"), lineWidth: 1)
                            }
                        Button {
                            // action
                        } label: {
                            Text("Change photo")
                                .font(Font.custom("Montserrat-Regular", size: 10))
                                .foregroundColor(Color("DarkGrayTextColor"))
                        }
                        Text("Satria Adhi Pradana")
                            .foregroundColor(Color("ProfileTextColor"))
                            .font(Font.custom("Montserrat-Bold", size: 20))
                        Button {
                            // action
                        } label: {
                            HStack {
                                Spacer()
                                Image("Upload")
                                    .resizable()
                                    .frame(width: 10, height: 12.5)
                                Spacer()
                                Text("Upload item")

                                Spacer()
                                Spacer()
                                    .frame(width: 10)
                                Spacer()
                            }
                        }
                        .roundedBlueStyle()
                    }
                }
            }
            .toolbar(.hidden)
        }
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
