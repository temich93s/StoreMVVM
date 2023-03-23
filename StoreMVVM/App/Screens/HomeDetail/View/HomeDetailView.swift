// HomeDetailView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Страница с товаром
struct HomeDetailView<ViewModel>: View where ViewModel: HomeDetailViewModelProtocol {
    // MARK: - Public Properties

    let tabBarSelection: Int

    @StateObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            BackgroundColorView()
            if viewModel.productDetail != nil {
                VStack {
                    ScrollView(showsIndicators: false) {
                        largeImageProductView
                        smallImagesProductView()
                            .padding(.vertical, 30)
                        descriptionProductView()
                    }
                    .padding(.top, 16)
                    footerProductView()
                }
                headerView
            }
            VStack {
                Spacer()
                StoreTabBarView(selection: tabBarSelection)
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
        .toolbar(.hidden)
        .ignoresSafeArea(.keyboard)
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator

    private var headerView: some View {
        VStack {
            HStack {
                Button(action: {
                    coordinator.pop()
                }, label: {
                    Image(NameImages.backLittle)
                        .resizable()
                })
                .frame(width: 6, height: 12)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            Spacer()
        }
    }

    // MARK: - Private Properties

    private var largeImageProductView: some View {
        ZStack {
            if let imageData = viewModel.productDetail?.imageData?[viewModel.selectedImageIndex] {
                HStack {
                    createImage(imageData)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 330, height: 280)
                        .clipped()
                        .cornerRadius(10)
                        .gesture(
                            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .onEnded { value in
                                    if value.translation.width < 0 {
                                        viewModel.leftSwipeAction()
                                    }
                                    if value.translation.width > 0 {
                                        viewModel.rightSwipeAction()
                                    }
                                }
                        )
                    Spacer()
                }
                .offset(x: -10)
                VStack(alignment: .leading) {
                    Spacer()
                    HStack {
                        Spacer()
                            .frame(width: 300)
                        productButtonsGroupView()
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 30)
                }
            }
        }
    }

    private var addToCardButtonView: some View {
        Button {
            coordinator.push(.addToCard)
        } label: {
            HStack {
                Spacer()
                Text("\(Constants.sharpText) \(viewModel.productCount)")
                    .opacity(0.5)
                Spacer()
                Text(Constants.addToCardText)
                Spacer()
            }
        }
        .frame(width: 200, height: 42)
        .multilineTextAlignment(.center)
        .background(Color(NameColors.backgroundButtonColor))
        .foregroundColor(Color(NameColors.foregroundTextButtonColor))
        .font(Font.custom(NameFonts.montserratBold, size: 12))
        .cornerRadius(13)
    }

    // MARK: - Private Methods

    private func productButtonsGroupView() -> some View {
        ZStack {
            VStack {
                Spacer()
                productButtonView(nameImage: NameImages.productHeartButton, action: {})
                Spacer()
                Image(NameImages.line)
                Spacer()
                productButtonView(nameImage: NameImages.productShareButton, action: {})
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(NameColors.foregroundTextButtonColor))
                    .frame(width: 42, height: 95)
            )
        }
        .frame(width: 42, height: 95)
    }

    private func productButtonView(nameImage: String, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            Image(nameImage)
        }
    }

    private func smallImagesProductView() -> some View {
        HStack {
            Spacer()
            if let imagesData = viewModel.productDetail?.imageData {
                HStack {
                    ForEach(0 ..< imagesData.count) { index in
                        smallImageProductView(index: index)
                            .frame(width: 85, height: 45)
                    }
                }
            }
            Spacer()
        }
    }

    private func smallImageProductView(index: Int) -> some View {
        Button {
            viewModel.setupImageIndex(index: index)
        } label: {
            HStack {
                if let imageData = viewModel.productDetail?.imageData?[index] {
                    Spacer()
                    createImage(imageData)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: viewModel.selectedImageIndex == index ? 85 : 67,
                            height: viewModel.selectedImageIndex == index ? 45 : 38
                        )
                        .clipped()
                        .cornerRadius(10)
                        .shadow(
                            radius: viewModel.selectedImageIndex == index ? 3 : 0,
                            x: 0,
                            y: viewModel.selectedImageIndex == index ? 5 : 0
                        )
                    Spacer()
                }
            }
        }
    }

    private func descriptionProductView() -> some View {
        HStack(alignment: .top) {
            if let productDetail = viewModel.productDetail {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(productDetail.name)
                            .foregroundColor(Color(NameColors.blackTextColor))
                            .font(Font.custom(NameFonts.montserratBold, size: 18))
                        Spacer()
                    }
                    Text(productDetail.description)
                        .foregroundColor(Color(NameColors.darkGrayTextColor))
                        .font(Font.custom(NameFonts.montserratRegular, size: 12))
                    HStack {
                        Image(NameImages.star)
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text("\(productDetail.rating, specifier: "%.1f")")
                            .foregroundColor(Color(NameColors.blackTextColor))
                            .font(Font.custom(NameFonts.montserratBold, size: 12))
                        Text("(\(productDetail.numberOfReviews) \(Constants.reviewsText)")
                            .foregroundColor(Color(NameColors.darkGrayTextColor))
                            .font(Font.custom(NameFonts.montserratRegular, size: 12))
                    }
                    Text(Constants.colorText)
                        .foregroundColor(Color(NameColors.darkGrayTextColor))
                        .font(Font.custom(NameFonts.montserratBold, size: 12))
                    HStack(spacing: 10) {
                        ForEach(0 ..< productDetail.colors.count) { index in
                            colorButtonView(index: index)
                        }
                    }
                }
                VStack {
                    HStack {
                        Spacer()
                        Text("\(Constants.dollarText) \(productDetail.price, specifier: "%.2f")")
                            .foregroundColor(Color(NameColors.blackTextColor))
                            .font(Font.custom(NameFonts.montserratBold, size: 16))
                    }
                    Spacer()
                }
                .frame(width: 130)
            }
        }
        .padding(.horizontal, 20)
    }

    private func colorButtonView(index: Int) -> some View {
        Button {
            viewModel.setupColorIndex(index: index)
        } label: {
            HStack {
                if let productDetail = viewModel.productDetail {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 36, height: 24)
                        .foregroundColor(Color(hex: productDetail.colors[index]))
                        .overlay {
                            if viewModel.selectedColorIndex == index {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(NameColors.darkGrayTextColor), lineWidth: 2)
                            }
                        }
                }
            }
        }
    }

    private func footerProductView() -> some View {
        ZStack {
            StoreBackgroundTabBarShape(cornerRadius: 28)
                .frame(height: 140)
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Text(Constants.quantityText)
                                .foregroundColor(Color(NameColors.darkGrayTextColor))
                                .font(Font.custom(NameFonts.montserratRegular, size: 12))
                            Spacer()
                        }
                        HStack {
                            footerbuttontView(imageName: NameImages.minusWhite) {
                                viewModel.decreaseProductCount()
                            }
                            footerbuttontView(imageName: NameImages.plusWhite) {
                                viewModel.increaseProductCount()
                            }
                            Spacer()
                        }
                    }
                    addToCardButtonView
                }
                .padding(.all, 15)
                Spacer()
                    .frame(height: 70)
            }
        }
        .frame(height: 140)
    }

    private func footerbuttontView(imageName: String, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            Image(imageName)
                .frame(width: 45, height: 22)
        }
        .background(Color(NameColors.backgroundButtonColor))
        .cornerRadius(13)
    }
}
