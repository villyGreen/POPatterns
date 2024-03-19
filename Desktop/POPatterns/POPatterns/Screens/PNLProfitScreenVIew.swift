//
//  PNLProfitScreenVIew.swift
//  POPatterns
//
//  Created by vadim.vitkovskiy on 19.03.2024.
//

import SwiftUI

struct PNLProfitScreenVIew: View {

    @Environment(\.presentationMode) var presentationMode

    @State var price = ""
    @State var exitePrice = ""
    @State var amount = ""
    @State var percentage = ""

    @State var result = ""
    @State var percentValue = ""

    var descriptionText = "PNL (Profit and Loss) is a crucial term in the context of trading and investing. It represents the net financial outcome of a trading position or investment over a certain period. You can calculate it by deducting the whole cost of purchasing an asset or investment from the total revenue you get when selling it."

    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, Color(hex: 0x13C0FF)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                Text("PNL ASSISTANT")
                    .font(.custom("Inter-Bold", size: 32))
                    .foregroundColor(.black)

                Text("<- BACK TO PATTERNS")
                    .padding(.vertical, 21)
                    .frame(maxWidth: .infinity)
                    .font(.custom("Inter-Medium", size: 15))
                    .foregroundColor(.black)
                    .padding(.top, 12)
                    .background(.white)
                    .cornerRadius(15)
                    .onTapGesture {
                        withAnimation {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }

                if result.isEmpty {
                    Text(descriptionText)
                        .padding(.vertical, 40)
                        .padding(.horizontal, 14)
                        .multilineTextAlignment(.center)
                        .font(.custom("Inter-Medium", size: 15))
                        .foregroundColor(.black)
                        .background(.white)
                        .padding(.top, 13)
                        .cornerRadius(15)

                    VStack(alignment: .center, spacing: 15) {
                        ScrollView {
                            TextField("", text: $price, prompt: Text("Entry price").foregroundColor(Color(hex: 0x13C0FF)))
                                .padding(16)
                                .background(.white)
                                .keyboardType(.numberPad)
                                .cornerRadius(15)

                            TextField("", text: $exitePrice, prompt: Text("Exit price").foregroundColor(Color(hex: 0x13C0FF)))
                                .padding(16)
                                .background(.white)
                                .keyboardType(.numberPad)
                                .cornerRadius(15)

                            TextField("", text: $amount, prompt: Text("Shares amount").foregroundColor(Color(hex: 0x13C0FF)))
                                .padding(16)
                                .background(.white)
                                .keyboardType(.numberPad)
                                .cornerRadius(15)

                            TextField("", text: $percentage, prompt: Text("Percentage of fees on profit, if any").foregroundColor(Color(hex: 0x13C0FF)))
                                .padding(16)
                                .background(.white)
                                .keyboardType(.numberPad)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.top, 30)
                } else {

                    Spacer()

                    ZStack {
                        Color(.white)
                            .frame(height: 201)
                            .cornerRadius(15)

                        VStack(spacing: 15) {
                            Text("PROFIT: \(result)")
                                .font(.custom("Inter-Medium", size: 20))
                                .foregroundColor(.black)
                            Text("Or")
                                .font(.custom("Inter-Medium", size: 20))
                                .foregroundColor(.black)
                            Text("\(percentValue)%")
                                .font(.custom("Inter-Bold", size: 30))
                                .foregroundColor(Color(hex: 0x13C0FF))
                        }
                    }

                    Spacer()
                }

                Spacer()

                Text(result.isEmpty ? "CALCULATE PNL" : "RECALCULATE")
                    .padding(.vertical, 21)
                    .frame(maxWidth: .infinity)
                    .font(.custom("Inter-Medium", size: 15))
                    .foregroundColor(Color(hex: 0x13C0FF))
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.top, 12)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            if result.isEmpty {
                                if !price.isEmpty && !exitePrice.isEmpty && !amount.isEmpty && !percentage.isEmpty {
                                    let value = (Int(exitePrice)! - Int(price)!) * Int(amount)!
                                    let percent = value / 100 * Int(percentage)!
                                    let total = value - percent
                                    result = String(Double(total))
                                    percentValue = String(Int(Double(total) / (Double(price)! * Double(amount)!) * 100))
                                }
                            } else {
                                result = ""
                                percentValue = ""
                                price = ""
                                exitePrice = ""
                                amount = ""
                                percentage = ""
                            }
                        }
                    }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .padding(.horizontal, 25)
        }
    }
}
