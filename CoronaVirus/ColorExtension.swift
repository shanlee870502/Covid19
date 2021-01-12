//
//  ColorExtension.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/9.
//

import Foundation
import SwiftUI

extension Color {
    static let CountryBgColor = Color(hex: "#456268", alpha: 1)
    static let CountryRowColor = Color(hex:"#79A3B1", alpha:0.8)
    static let CountryCardColor = Color(hex:"#fcf8ec", alpha:1)
    
    init(hex: String, alpha: CGFloat = 1.0) {
            var hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            if hex.hasPrefix("#") {
                hex = String(hex.dropFirst())
            }
            assert(hex.count == 3 || hex.count == 6 || hex.count == 8, "Invalid hex code used. hex count is #(3, 6, 8).")
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (r, g, b) = (1, 1, 0)
            }

            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue:  Double(b) / 255,
                opacity: Double(alpha)
            )
        }
}
