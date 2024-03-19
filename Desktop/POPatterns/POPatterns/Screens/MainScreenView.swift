//
//  MainScreenView.swift
//  POPatterns
//
//  Created by vadim.vitkovskiy on 19.03.2024.
//

import SwiftUI

enum MainScreenTab {
    case patterns
    case favorite
}

struct MainScreenView: View {

    @State private var currentTab: MainScreenTab = .patterns
    @State private var selectedPattern: Patterns = .ascendingTriangle
    @State private var detailScreenIsShowed = false
    @State private var pnlCalculatorIsShowed = false

    @State var favouritesPatterns: [Patterns] = []

    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, Color(hex: 0x13C0FF)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                HStack(spacing: 16) {
                    Text("PATTERNS")
                        .font(.custom("Inter-Bold", size: 32))
                        .foregroundColor( currentTab == .patterns ? .black : Color(hex: 0x8D9192))
                        .onTapGesture {
                            withAnimation {
                                currentTab = .patterns
                            }
                        }
                    Text("FAVORITE")
                        .font(.custom("Inter-Bold", size: 32))
                        .foregroundColor( currentTab == .favorite ? .black : Color(hex: 0x8D9192))
                        .onTapGesture {
                            withAnimation {
                                currentTab = .favorite
                            }
                        }
                }

                Button {
                    withAnimation {
                        pnlCalculatorIsShowed.toggle()
                    }
                } label: {
                    Text("PNL ASSISTANT ->")
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(15)
                        .foregroundColor(.black)
                }
                if currentTab == .favorite && favouritesPatterns.isEmpty {
                    VStack {
                        Spacer()

                        Text("No favourites patterns")
                            .font(.custom("Inter-Medium", size: 25))
                            .foregroundColor(.white)

                        Spacer()
                    }
                } else {
                    ScrollView {
                        ForEach(currentTab == .patterns ? Patterns.allCases : favouritesPatterns, id: \.self) { pattern in
                            ZStack {
                                Color(.white)
                                    .cornerRadius(15)
                                    .frame(height: 146)

                                HStack {
                                    Text(pattern.title)
                                        .font(.custom("Inter-Medium", size: 25))
                                        .foregroundColor(Color(hex: 0x13C0FF))

                                    Spacer()

                                    Image(.arrow)
                                }
                                .padding(.horizontal, 13)
                            }
                            .onTapGesture {
                                withAnimation {
                                    selectedPattern = pattern
                                    detailScreenIsShowed.toggle()
                                }
                            }
                        }
                    }
                    .padding(.top, 20)

                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $detailScreenIsShowed) {
                DetailScreenView(pattern: selectedPattern, favouritesPatterns: $favouritesPatterns)
            }
            .fullScreenCover(isPresented: $pnlCalculatorIsShowed) {
                PNLProfitScreenVIew()
            }
            .padding(.horizontal, 30)
        }
    }
}
