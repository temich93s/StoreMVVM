// ProfileView.swift
// Copyright © SolovevAA. All rights reserved.

import PhotosUI
import SwiftUI

/// Экран профиля пользователя
struct ProfileView: View {
    enum MenuType {
        case link
        case empty
        case balance(Int)
    }

    // MARK: - Public Methods

    var body: some View {
        ZStack {
            ZStack {
                Color("BackgroundMainViewColor")
                    .ignoresSafeArea()
                VStack {
                    headerView
                    ScrollView {
                        profileImageView
                        profilePhotosPickerView
                        userNameTextView
                        uploadItemButtonView
                        profileMenuListView
                    }
                }
            }
            .toolbar(.hidden)
        }
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator

    @State private var selectedPhotosPickerItem: PhotosPickerItem?
    @State private var selectedPhotosPickerData: Data?

    private var headerView: some View {
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
        .padding(.vertical, 10)
    }

    private var profileImageView: some View {
        guard let selectedPhotosPickerData,
              let uiImage = UIImage(data: selectedPhotosPickerData)
        else {
            return Image("ProfileImageMock")
                .resizable()
                .userImageStyle()
        }
        return Image(uiImage: uiImage)
            .resizable()
            .userImageStyle()
    }

    private var profilePhotosPickerView: some View {
        PhotosPicker(selection: $selectedPhotosPickerItem, matching: .images, photoLibrary: .shared()) {
            Text("Change photo")
                .font(Font.custom("Montserrat-Regular", size: 10))
                .foregroundColor(Color("DarkGrayTextColor"))
        }
        .onChange(of: selectedPhotosPickerItem) { newPhotosPickerItem in
            Task {
                if let data = try? await newPhotosPickerItem?.loadTransferable(type: Data.self) {
                    selectedPhotosPickerData = data
                }
            }
        }
    }

    private var userNameTextView: some View {
        Text("Satria Adhi Pradana")
            .foregroundColor(Color("ProfileNameTextColor"))
            .font(Font.custom("Montserrat-Bold", size: 20))
            .padding(.vertical, 10)
    }

    private var uploadItemButtonView: some View {
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
        .padding(.vertical, 10)
    }

    private var profileMenuListView: some View {
        VStack {
            menuProfileView(menuText: "Trade store", imageName: "Card", menuType: .link, buttonAction: {})
            menuProfileView(menuText: "Payment method", imageName: "Card", menuType: .link, buttonAction: {})
            menuProfileView(menuText: "Balance", imageName: "Card", menuType: .balance(1593), buttonAction: {})
            menuProfileView(menuText: "Trade history", imageName: "Card", menuType: .link, buttonAction: {})
            menuProfileView(menuText: "Restore purchase", imageName: "Restore", menuType: .link, buttonAction: {})
            menuProfileView(menuText: "Help", imageName: "Help", menuType: .empty, buttonAction: {})
            menuProfileView(
                menuText: "Log out",
                imageName: "LogOut",
                menuType: .empty,
                buttonAction: { coordinator.popToRoot() }
            )
        }
    }

    // MARK: - Private Methods

    private func menuProfileView(
        menuText: String,
        imageName: String,
        menuType: MenuType,
        buttonAction: @escaping () -> ()
    ) -> some View {
        Button {
            buttonAction()
        } label: {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color("TabBarCircleColor"))
                        .frame(width: 40)
                    Image(imageName)
                }
                Text(menuText)
                    .foregroundColor(Color("ProfileMenuTextColor"))
                    .font(Font.custom("Montserrat-Regular", size: 15))
                Spacer()
                switch menuType {
                case .link:
                    Image("Chevron")
                case .empty:
                    EmptyView()
                case let .balance(balance):
                    Text("$ \(balance)")
                        .foregroundColor(Color("ProfileMenuTextColor"))
                        .font(Font.custom("Montserrat-Regular", size: 15))
                }
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 40)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
