//
//  DetailScreenView.swift
//  POPatterns
//
//  Created by vadim.vitkovskiy on 19.03.2024.
//

import SwiftUI

struct DetailScreenView: View {

    var pattern: Patterns

    @Binding var favouritesPatterns: [Patterns]

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, Color(hex: 0x13C0FF)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Text(pattern.title)
                    .font(.custom("Inter-Bold", size: 32))
                    .foregroundColor(.black)
                    .padding(.top, 40)

                Image(pattern.image)
                    .resizable()
                    .frame(height: 200)
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.horizontal, 24)
                    .padding(.top, 30)

                ScrollView {
                    Text(pattern.description)
                        .font(.custom("Inter-Medium", size: 15))
                        .foregroundColor(.black)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 28)
                }
                .frame(height: 346)
                .background(.white)
                .cornerRadius(15)
                .padding(.horizontal, 24)

                VStack(spacing: 8) {
                    Text(favouritesPatterns.contains(pattern) ? "REMOVE FROM FAVORITES" : "ADD TO FAVORITES")
                        .padding(.vertical, 21)
                        .frame(maxWidth: .infinity)
                        .font(.custom("Inter-Medium", size: 15))
                        .foregroundColor(favouritesPatterns.contains(pattern) ? .black : Color(hex: 0x13C0FF))
                        .background(.white)
                        .cornerRadius(15)
                        .onTapGesture {
                            withAnimation {
                                if favouritesPatterns.contains(pattern) {
                                    favouritesPatterns.removeAll { $0 == pattern }
                                } else {
                                    favouritesPatterns.append(pattern)
                                }
                            }
                        }

                    Text("BACK TO LIST")
                        .padding(.vertical, 21)
                        .frame(maxWidth: .infinity)
                        .font(.custom("Inter-Medium", size: 15))
                        .foregroundColor(Color(hex: 0x13C0FF))
                        .background(.white)
                        .cornerRadius(15)
                        .onTapGesture {
                            withAnimation {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                }
                .padding(.horizontal, 23)

                Spacer()
            }
        }
    }
}
