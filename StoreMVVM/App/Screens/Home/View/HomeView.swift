// HomeView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Домашняя страница с товарами
struct HomeView: View {
    let tabBarSelection: Int

    var body: some View {
        ZStack {
            BackgroundColorView()
            VStack {
                headerView
                ZStack {
                    VStack {
                        Spacer()
                            .frame(height: 30)
                        listCategoryView(categories: mockCategories)
                        ScrollView(showsIndicators: false) {
                            recomendationListView(
                                categoryName: "Latest deals",
                                products: viewModel.lastDeals,
                                viewSize: .medium
                            )
                            recomendationListView(
                                categoryName: "Flash sale",
                                products: viewModel.flashSales,
                                viewSize: .large
                            )
                            recomendationListView(categoryName: "Brands", products: viewModel.brands, viewSize: .medium)
                        }
                        .padding(.horizontal)
                        StoreTabBarView(selection: tabBarSelection)
                    }
                    VStack {
                        searchView
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchProductData()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .toolbar(.hidden)
        .ignoresSafeArea(.keyboard)
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator

    @StateObject private var viewModel = HomeViewModel()

    private var headerView: some View {
        HStack(alignment: .top) {
            Button(action: {}, label: {
                Image("HorizontalLine")
                    .resizable()
            })
            .frame(width: 20, height: 20)
            Spacer()
            Spacer()
                .frame(width: 40)
            Spacer()
            titleView
            Spacer()
            userProfileView
                .frame(width: 60)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }

    private var titleView: some View {
        HStack {
            Text("Trade buy")
                .foregroundColor(Color(NameColors.blackTextColor))
            Text("bata")
                .foregroundColor(Color("StoreNameTextColor"))
        }
        .font(Font.custom(NameFonts.montserratBold, size: 20))
    }

    private var searchView: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .trailing) {
                TextField("What are you looking for ?", text: $viewModel.searchText)
                    .onChange(of: viewModel.searchText) { newValue in
                        print(newValue)
                        viewModel.deferredSearchTextAction(text: newValue)
                    }
                Button(action: {
                    viewModel.searchTextAction(text: viewModel.searchText)
                }, label: {
                    Image("Search")
                        .padding(.trailing, 15)
                })
            }
            .roundedGrayStyle()
            .submitLabel(.done)
            ForEach(0 ..< viewModel.listWords.count, id: \.self) { index in
                resultSearchTextView(text: viewModel.listWords[index])
            }
        }
    }

    private var userProfileView: some View {
        VStack {
            Image("ProfileImageMock")
                .resizable()
                .userImageStyle(size: 30)
            HStack {
                Button {} label: {
                    Text("Location")
                        .font(Font.custom(NameFonts.montserratRegular, size: 10))
                        .foregroundColor(Color(NameColors.darkGrayTextColor))
                    Image("BottomChevron")
                }
            }
        }
    }

    // MARK: - Private Methods

    private func listCategoryView(categories: [Category]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< categories.count, id: \.self) { index in
                    categoryView(category: categories[index])
                }
            }
        }
        .padding(.vertical, 10)
    }

    private func resultSearchTextView(text: String) -> some View {
        Button {} label: {
            Text(text)
                .roundedGrayStyle()
        }
    }

    private func recomendationListView(
        categoryName: String,
        products: [Product],
        viewSize: ProductViewSizeType
    ) -> some View {
        VStack {
            if !products.isEmpty {
                recomendationTitleView(name: categoryName)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0 ..< products.count, id: \.self) { index in
                            productView(
                                product: products[index],
                                viewSize: viewSize,
                                buttonAction: { coordinator.push(.homeDetail) }
                            )
                        }
                    }
                }
            }
        }
    }

    private func productView(
        product: Product,
        viewSize: ProductViewSizeType,
        buttonAction: @escaping () -> ()
    ) -> some View {
        Button { buttonAction() } label: {
            ZStack {
                productImageView(imageData: product.imageData, viewSize: viewSize)
                productDescriptionView(product: product)
                circleButtonView(viewSize: viewSize, plusButtonAction: {}, heartButtonAction: {})
                if viewSize == .large {
                    profileImageView(product: product)
                }
            }
        }
        .padding(.horizontal, 4)
    }

    private func productImageView(imageData: Data?, viewSize: ProductViewSizeType) -> some View {
        createImage(imageData)
            .resizable()
            .scaledToFill()
            .frame(width: viewSize.frameWidth, height: viewSize.frameHeight)
            .clipped()
            .cornerRadius(10)
    }

    private func productDescriptionView(product: Product) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Spacer()
                if let category = product.category {
                    Text(category)
                        .font(Font.custom(NameFonts.montserratBold, size: 9))
                        .foregroundColor(Color(NameColors.blackTextColor))
                        .padding(.vertical, 3)
                        .padding(.horizontal, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(NameColors.backgroundCategoryColor))
                        )
                }
                if let name = product.name {
                    Text(name)
                        .font(Font.custom(NameFonts.montserratBold, size: 11))
                        .foregroundColor(Color("WhiteTextColor"))
                        .multilineTextAlignment(.leading)
                        .frame(height: 30, alignment: .topLeading)
                }
                if let price = product.price {
                    Text("$ \(price, specifier: "%.2f")")
                        .font(Font.custom(NameFonts.montserratBold, size: 9))
                        .foregroundColor(Color("WhiteTextColor"))
                }
            }
            .padding(.all, 5)
            .frame(width: 100)
            Spacer()
        }
    }

    private func circleButtonView(
        viewSize: ProductViewSizeType,
        plusButtonAction: @escaping () -> (),
        heartButtonAction: @escaping () -> ()
    ) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                if viewSize == .large {
                    GrayCircleButtonView(
                        diameter: viewSize.darkHeartButtonDiameter,
                        imageName: "DarkHeart",
                        action: { heartButtonAction() }
                    )
                }
                GrayCircleButtonView(
                    diameter: viewSize.plusButtonDiameter,
                    imageName: "Plus",
                    action: { plusButtonAction() }
                )
            }
        }
        .padding(.all, 5)
    }

    private func profileImageView(product: Product) -> some View {
        VStack {
            HStack {
                Image("ProfileImageMock")
                    .resizable()
                    .userImageStyle(size: 30)
                Spacer()
                if let discount = product.discount {
                    Text("\(discount, specifier: "%.0f")% off")
                        .font(Font.custom(NameFonts.montserratBold, size: 10))
                        .foregroundColor(Color("WhiteTextColor"))
                        .padding(.vertical, 3)
                        .padding(.horizontal, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("SaleBackgroundColor"))
                        )
                }
            }
            Spacer()
        }
        .padding(.all, 10)
    }

    private func recomendationTitleView(name: String) -> some View {
        HStack {
            Text(name)
                .font(Font.custom(NameFonts.montserratBold, size: 20))
                .foregroundColor(Color("RecomendationStoreTextColor"))
            Spacer()
            Button {} label: {
                Text("View all")
                    .font(Font.custom(NameFonts.montserratRegular, size: 12))
                    .foregroundColor(Color(NameColors.darkGrayTextColor))
            }
        }
    }

    private func categoryView(category: Category) -> some View {
        Button {} label: {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color("LightGrayCircleColor"))
                        .frame(width: 40)
                    Image(category.categoryImageName)
                }
                Text(category.categoryName)
                    .font(Font.custom(NameFonts.montserratRegular, size: 10))
                    .foregroundColor(Color(NameColors.darkGrayTextColor))
            }
            .frame(width: 65)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(tabBarSelection: 0)
    }
}
