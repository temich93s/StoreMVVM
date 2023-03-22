// HomeDetailView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Страница с товаром
struct HomeDetailView: View {
    var body: some View {
        ZStack {
            BackgroundColorView()
            VStack {
                ScrollView(showsIndicators: false) {
                    largeImageProductView(imageName: "FrontSneakers", heartButtonAction: {}, shareButtonAction: {})
                }
                .padding(.top, 16)
            }
            headerView
        }
        .toolbar(.hidden)
        .onAppear {
            // viewModel.fetchData()
        }
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator

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

    private func largeImageProductView(
        imageName: String,
        heartButtonAction: @escaping () -> (),
        shareButtonAction: @escaping () -> ()
    ) -> some View {
        ZStack {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 330, height: 280)
                    .clipped()
                    .cornerRadius(10)
                Spacer()
            }
            .offset(x: -10)
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Spacer()
                        .frame(width: 300)
                    productButtonsGroupView(heartButtonAction: heartButtonAction, shareButtonAction: shareButtonAction)
                    Spacer()
                }
                Spacer()
                    .frame(height: 30)
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
        VStack {}
    }
}

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailView()
    }
}
