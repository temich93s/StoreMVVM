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
                ScrollView {
                    recomendationStoreView(name: "Latest deals")
                    listLastDealView(lastDeals: mockLastDeals)
                    recomendationStoreView(name: "Flash sale")
                    listFlashSaleView(flashSale: mockFlashSale)
                }
                .padding(.horizontal)
            }
            .searchable(text: $searchText)
        }
        .toolbar(.hidden)
    }

    // MARK: - Private Properties

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
                ForEach(0 ..< categories.count) { index in
                    categoryView(category: categories[index])
                }
            }
        }
    }

    private func listLastDealView(lastDeals: [LastDeal]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< lastDeals.count) { index in
                    lastDealView(lastDeal: lastDeals[index])
                }
            }
        }
    }

    private func listFlashSaleView(flashSale: [FlashSale]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< flashSale.count) { index in
                    flashSaleView(flashSale: flashSale[index])
                }
            }
        }
    }

    private func recomendationStoreView(name: String) -> some View {
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

    private func lastDealView(lastDeal: LastDeal) -> some View {
        Button {} label: {
            ZStack {
                Image(lastDeal.imageUrl)
                    .resizable()
                    .cornerRadius(10)
                    .frame(width: 115, height: 150)
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Spacer()
                        Text(lastDeal.category)
                            .font(Font.custom("Montserrat-Bold", size: 8))
                            .foregroundColor(Color("BlackTextColor"))
                            .padding(.vertical, 3)
                            .padding(.horizontal, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("BackgroundCategoryColor"))
                            )
                        Text(lastDeal.name)
                            .font(Font.custom("Montserrat-Bold", size: 10))
                            .foregroundColor(Color("WhiteTextColor"))
                            .multilineTextAlignment(.leading)
                        Text("$ \(lastDeal.price)")
                            .font(Font.custom("Montserrat-Bold", size: 8))
                            .foregroundColor(Color("WhiteTextColor"))
                    }
                    .padding(.all, 5)
                    .frame(width: 95, height: 150)
                    Spacer()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        GrayCircleButtonView(diameter: 20, imageName: "Plus", action: {})
                            .padding(.all, 5)
                    }
                }
            }
        }
        .padding(.horizontal, 4)
    }

    private func flashSaleView(flashSale: FlashSale) -> some View {
        Button {} label: {
            ZStack {
                Image(flashSale.imageUrl)
                    .resizable()
                    .cornerRadius(10)
                    .frame(width: 175, height: 220)
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Spacer()
                        Text(flashSale.category)
                            .font(Font.custom("Montserrat-Bold", size: 8))
                            .foregroundColor(Color("BlackTextColor"))
                            .padding(.vertical, 3)
                            .padding(.horizontal, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("BackgroundCategoryColor"))
                            )
                        Text(flashSale.name)
                            .font(Font.custom("Montserrat-Bold", size: 12))
                            .foregroundColor(Color("WhiteTextColor"))
                            .multilineTextAlignment(.leading)
                        Text("$ \(flashSale.price)")
                            .font(Font.custom("Montserrat-Bold", size: 10))
                            .foregroundColor(Color("WhiteTextColor"))
                    }
                    .padding(.all, 10)
                    .frame(width: 100)
                    Spacer()
                }
                VStack {
                    HStack {
                        Image("ProfileImageMock")
                            .resizable()
                            .userImageStyle(size: 30)
                        Spacer()
                        Text("\(flashSale.discount, specifier: "%.0f")% off")
                            .font(Font.custom("Montserrat-Bold", size: 10))
                            .foregroundColor(Color("WhiteTextColor"))
                            .padding(.vertical, 3)
                            .padding(.horizontal, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("SaleBackgroundColor"))
                            )
                    }
                    Spacer()
                }
                .padding(.all, 10)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        GrayCircleButtonView(diameter: 28, imageName: "DarkHeart", action: {})
                        GrayCircleButtonView(diameter: 35, imageName: "Plus", action: {})
                    }
                }
                .padding(.all, 5)
            }
        }
        .padding(.horizontal, 2)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
