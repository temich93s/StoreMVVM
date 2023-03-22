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
                    smallImagesProductView()
                        .padding(.vertical, 30)
                    descriptionProductView()
                }
                .padding(.top, 16)
                footerProductView()
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
        HStack {
            Spacer()
            Button {
                // action
            } label: {
                Image("LeadingSneakers")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 67, height: 38)
                    .clipped()
                    .cornerRadius(10)
            }
            Button {
                // action
            } label: {
                Image("FrontSneakers")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 45)
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 3, x: 0, y: 5)
            }
            Button {
                // action
            } label: {
                Image("TrailingSneakers")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 67, height: 38)
                    .clipped()
                    .cornerRadius(10)
            }
            Spacer()
        }
    }

    private func descriptionProductView() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("New Balance Sneakers")
                        .foregroundColor(Color("BlackTextColor"))
                        .font(Font.custom("Montserrat-Bold", size: 18))
                    Spacer()
                }
                Text("Features waterproof, fire, air resistant shoes. all changed when the country of fire attacked")
                    .foregroundColor(Color("DarkGrayTextColor"))
                    .font(Font.custom("Montserrat-Regular", size: 12))
                HStack {
                    Image("Star")
                        .resizable()
                        .frame(width: 10, height: 10)
                    Text("3.4")
                        .foregroundColor(Color("BlackTextColor"))
                        .font(Font.custom("Montserrat-Bold", size: 12))
                    Text("(4000 reviews)")
                        .foregroundColor(Color("DarkGrayTextColor"))
                        .font(Font.custom("Montserrat-Regular", size: 12))
                }
                Text("Color:")
                    .foregroundColor(Color("DarkGrayTextColor"))
                    .font(Font.custom("Montserrat-Bold", size: 12))
                HStack(spacing: 10) {
                    Button {
                        // action
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 36, height: 24)
                            .foregroundColor(.white)
                            .background(
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("DarkGrayTextColor"), lineWidth: 2)
                            }
                    }
                    Button {
                        // action
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 36, height: 24)
                            .foregroundColor(.gray)
                            .background(
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("DarkGrayTextColor"), lineWidth: 2)
                            }
                    }
                    Button {
                        // action
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 36, height: 24)
                            .foregroundColor(.black)
                            .background(
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("DarkGrayTextColor"), lineWidth: 2)
                            }
                    }
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Text("$ 22.50")
                        .foregroundColor(Color("BlackTextColor"))
                        .font(Font.custom("Montserrat-Bold", size: 16))
                }
                Spacer()
            }
            .frame(width: 130)
        }
        .padding(.horizontal, 20)
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
                                // action
                            } label: {
                                Image("MinusWhite")
                            }
                            .frame(width: 45, height: 22)
                            .multilineTextAlignment(.center)
                            .background(Color("BackgroundButtonColor"))
                            .foregroundColor(Color("ForegroundTextButtonColor"))
                            .font(Font.custom("Montserrat-Bold", size: 15))
                            .cornerRadius(13)
                            Button {
                                // action
                            } label: {
                                Image("PlusWhite")
                            }
                            .frame(width: 45, height: 22)
                            .multilineTextAlignment(.center)
                            .background(Color("BackgroundButtonColor"))
                            .foregroundColor(Color("ForegroundTextButtonColor"))
                            .font(Font.custom("Montserrat-Bold", size: 15))
                            .cornerRadius(13)
                            Spacer()
                        }
                    }
                    Button {
                        // action
                    } label: {
                        HStack {
                            Spacer()
                            Text("#2,500")
                                .opacity(0.5)
                            Spacer()
                            Text("Sign in")
                            Spacer()
                        }
                    }
                    .frame(width: 200, height: 42)
                    .multilineTextAlignment(.center)
                    .background(Color("BackgroundButtonColor"))
                    .foregroundColor(Color("ForegroundTextButtonColor"))
                    .font(Font.custom("Montserrat-Bold", size: 15))
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
