// ProfileView.swift
// Copyright © SolovevAA. All rights reserved.

import PhotosUI
import SwiftUI

/// Экран профиля пользователя
struct ProfileView<ViewModel>: View where ViewModel: ProfileViewModelProtocol {
    // MARK: - Public Methods

    let tabBarSelection: Int

    @StateObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            BackgroundColorView()
            VStack {
                headerView
                ScrollView {
                    profileImageView
                    profilePhotosPickerView
                    userNameTextView
                    uploadItemButtonView
                    profileMenuListView
                }
                StoreTabBarView(selection: tabBarSelection)
            }
        }
        .toolbar(.hidden)
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator

    @State private var selectedPhotosPickerItem: PhotosPickerItem?

    private var headerView: some View {
        HStack {
            Button(action: {
                coordinator.popToRoot()
            }, label: {
                Image(NameImages.back)
                    .resizable()
            })
            .frame(width: 20, height: 20)
            Spacer()
            Text(Constants.profileText)
                .font(Font.custom(NameFonts.montserratBold, size: 20))
                .foregroundColor(Color(NameColors.blackTextColor))
            Spacer()
            Spacer()
                .frame(width: 20)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }

    private var profileImageView: some View {
        guard let selectedPhotosPickerData = viewModel.selectedPhotosPickerData,
              let uiImage = UIImage(data: selectedPhotosPickerData)
        else {
            return Image(NameImages.profileImageMock)
                .resizable()
                .userImageStyle(size: 60)
        }
        return Image(uiImage: uiImage)
            .resizable()
            .userImageStyle(size: 60)
    }

    private var profilePhotosPickerView: some View {
        PhotosPicker(selection: $selectedPhotosPickerItem, matching: .images, photoLibrary: .shared()) {
            Text(Constants.changePhotoText)
                .font(Font.custom(NameFonts.montserratRegular, size: 10))
                .foregroundColor(Color(NameColors.darkGrayTextColor))
        }
        .onChange(of: selectedPhotosPickerItem) { newPhotosPickerItem in
            Task {
                if let data = try? await newPhotosPickerItem?.loadTransferable(type: Data.self) {
                    viewModel.selectedPhotosPickerData = data
                }
            }
        }
    }

    private var userNameTextView: some View {
        Text(Constants.satriaAdhiPradanaText)
            .foregroundColor(Color(NameColors.profileNameTextColor))
            .font(Font.custom(NameFonts.montserratBold, size: 20))
            .padding(.vertical, 10)
    }

    private var uploadItemButtonView: some View {
        Button {} label: {
            HStack {
                Spacer()
                Image(NameImages.upload)
                    .resizable()
                    .frame(width: 10, height: 12.5)
                Spacer()
                Text(Constants.uploadItemText)
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
            ForEach(0 ..< viewModel.menuItems.count, id: \.self) { index in
                menuProfileView(
                    menuText: viewModel.menuItems[index].menuText,
                    imageName: viewModel.menuItems[index].imageName,
                    menuType: viewModel.menuItems[index].menuType,
                    buttonAction: index == 6 ? { coordinator.popToRoot() } : {}
                )
            }
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
                        .fill(Color(NameColors.lightGrayCircleColor))
                        .frame(width: 40)
                    Image(imageName)
                }
                Text(menuText)
                    .foregroundColor(Color(NameColors.profileMenuTextColor))
                    .font(Font.custom(NameFonts.montserratRegular, size: 15))
                Spacer()
                switch menuType {
                case .link:
                    Image(NameImages.chevron)
                case .empty:
                    EmptyView()
                case let .balance(balance):
                    Text("\(Constants.dollarText) \(balance)")
                        .foregroundColor(Color(NameColors.profileMenuTextColor))
                        .font(Font.custom(NameFonts.montserratRegular, size: 15))
                }
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 40)
    }
}
