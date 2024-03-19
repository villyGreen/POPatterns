//
//  View+Extensions.swift
//  POPatterns
//
//  Created by vadim.vitkovskiy on 19.03.2024.
//

import SwiftUI

extension Color {
    init(hex: Int) {
        self.init(red: hex.ff(16), green: hex.ff(08), blue: hex.ff(00))
    }
}

extension Int {
    func ff(_ shift: Int) -> Double {
        return Double((self >> shift) & 0xff) / 255
    }
}

