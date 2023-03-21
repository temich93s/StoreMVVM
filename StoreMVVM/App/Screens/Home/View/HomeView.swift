// HomeView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Домашняя страница с товарами
struct HomeView: View {
    var body: some View {
        ZStack {
            BackgroundColorView()
            VStack {
                headerView
                Text("Searchbar")
                listCategoryView(categories: mockCategories)
                ScrollView(showsIndicators: false) {
                    recomendationListView(
                        categoryName: "Latest deals",
                        products: viewModel.lastDeals,
                        viewSize: .medium
                    )
                    recomendationListView(categoryName: "Flash sale", products: viewModel.flashSales, viewSize: .large)
                    recomendationListView(categoryName: "Brands", products: viewModel.brands, viewSize: .medium)
                }
                .padding(.horizontal)
            }
            .searchable(text: $searchText)
        }
        .toolbar(.hidden)
        .onAppear {
            viewModel.fetchData()
        }
    }

    // MARK: - Private Properties

    @StateObject private var viewModel = HomeViewModel()

    @State private var searchText = ""

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
                .foregroundColor(Color("BlackTextColor"))
            Text("bata")
                .foregroundColor(Color("StoreNameTextColor"))
        }
        .font(Font.custom("Montserrat-Bold", size: 20))
    }

    private var userProfileView: some View {
        VStack {
            Image("ProfileImageMock")
                .resizable()
                .userImageStyle(size: 30)
            HStack {
                Button {} label: {
                    Text("Location")
                        .font(Font.custom("Montserrat-Regular", size: 10))
                        .foregroundColor(Color("DarkGrayTextColor"))
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
                            productView(product: products[index], viewSize: viewSize)
                        }
                    }
                }
            }
        }
    }

    private func productView(product: Product, viewSize: ProductViewSizeType) -> some View {
        Button {} label: {
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
                        .font(Font.custom("Montserrat-Bold", size: 9))
                        .foregroundColor(Color("BlackTextColor"))
                        .padding(.vertical, 3)
                        .padding(.horizontal, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("BackgroundCategoryColor"))
                        )
                }
                if let name = product.name {
                    Text(name)
                        .font(Font.custom("Montserrat-Bold", size: 11))
                        .foregroundColor(Color("WhiteTextColor"))
                        .multilineTextAlignment(.leading)
                        .frame(height: 30, alignment: .topLeading)
                }
                if let price = product.price {
                    Text("$ \(price, specifier: "%.2f")")
                        .font(Font.custom("Montserrat-Bold", size: 9))
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
                        .font(Font.custom("Montserrat-Bold", size: 10))
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
                .font(Font.custom("Montserrat-Bold", size: 20))
                .foregroundColor(Color("RecomendationStoreTextColor"))
            Spacer()
            Button {} label: {
                Text("View all")
                    .font(Font.custom("Montserrat-Regular", size: 12))
                    .foregroundColor(Color("DarkGrayTextColor"))
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
                    .font(Font.custom("Montserrat-Regular", size: 10))
                    .foregroundColor(Color("DarkGrayTextColor"))
            }
            .frame(width: 65)
        }
    }

    func createImage(_ value: Data?) -> Image {
        let image = UIImage(data: value ?? Data()) ?? UIImage()
        return Image(uiImage: image)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
