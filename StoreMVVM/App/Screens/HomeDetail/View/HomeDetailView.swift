// HomeDetailView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Страница с товаром
struct HomeDetailView: View {
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
        }
        .toolbar(.hidden)
        .onAppear {
            viewModel.fetchData()
        }
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator

    @StateObject private var viewModel = HomeDetailViewModel()

    private var headerView: some View {
        VStack {
            HStack {
                Button(action: {
                    coordinator.pop()
                }, label: {
                    Image("BackLittle")
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

    // MARK: - Private Methods

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
                        productButtonsGroupView(heartButtonAction: {}, shareButtonAction: {})
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 30)
                }
            }
        }
    }

    private func productButtonsGroupView(
        heartButtonAction: @escaping () -> (),
        shareButtonAction: @escaping () -> ()
    ) -> some View {
        ZStack {
            VStack {
                Spacer()
                productButtonView(nameImage: "ProductHeartButton", action: heartButtonAction)
                Spacer()
                Image("Line")
                Spacer()
                productButtonView(nameImage: "ProductShareButton", action: shareButtonAction)
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("ForegroundTextButtonColor"))
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
                            .foregroundColor(Color("BlackTextColor"))
                            .font(Font.custom("Montserrat-Bold", size: 18))
                        Spacer()
                    }
                    Text(productDetail.description)
                        .foregroundColor(Color("DarkGrayTextColor"))
                        .font(Font.custom("Montserrat-Regular", size: 12))
                    HStack {
                        Image("Star")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text("\(productDetail.rating, specifier: "%.1f")")
                            .foregroundColor(Color("BlackTextColor"))
                            .font(Font.custom("Montserrat-Bold", size: 12))
                        Text("(\(productDetail.numberOfReviews) reviews)")
                            .foregroundColor(Color("DarkGrayTextColor"))
                            .font(Font.custom("Montserrat-Regular", size: 12))
                    }
                    Text("Color:")
                        .foregroundColor(Color("DarkGrayTextColor"))
                        .font(Font.custom("Montserrat-Bold", size: 12))
                    HStack(spacing: 10) {
                        ForEach(0 ..< productDetail.colors.count) { index in
                            colorButtonView(index: index)
                        }
                    }
                }
                VStack {
                    HStack {
                        Spacer()
                        Text("$ \(productDetail.price, specifier: "%.2f")")
                            .foregroundColor(Color("BlackTextColor"))
                            .font(Font.custom("Montserrat-Bold", size: 16))
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
                                    .stroke(Color("DarkGrayTextColor"), lineWidth: 2)
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
                            Text("Quantity:")
                                .foregroundColor(Color("DarkGrayTextColor"))
                                .font(Font.custom("Montserrat-Regular", size: 12))
                            Spacer()
                        }
                        HStack {
                            Button {
                                viewModel.decreaseProductCount()
                            } label: {
                                Image("MinusWhite")
                                    .frame(width: 45, height: 22)
                            }
                            .background(Color("BackgroundButtonColor"))
                            .cornerRadius(13)
                            Button {
                                viewModel.increaseProductCount()
                            } label: {
                                Image("PlusWhite")
                                    .frame(width: 45, height: 22)
                            }
                            .background(Color("BackgroundButtonColor"))
                            .cornerRadius(13)
                            Spacer()
                        }
                    }
                    Button {
                        coordinator.push(.addToCard)
                    } label: {
                        HStack {
                            Spacer()
                            Text("# \(viewModel.productCount)")
                                .opacity(0.5)
                            Spacer()
                            Text("ADD TO CARD")
                            Spacer()
                        }
                    }
                    .frame(width: 200, height: 42)
                    .multilineTextAlignment(.center)
                    .background(Color("BackgroundButtonColor"))
                    .foregroundColor(Color("ForegroundTextButtonColor"))
                    .font(Font.custom("Montserrat-Bold", size: 12))
                    .cornerRadius(13)
                }
                .padding(.all, 15)
                Spacer()
                    .frame(height: 70)
            }
        }
        .frame(height: 140)
    }
}

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailView()
    }
}
