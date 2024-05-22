//
//  PriceFormatter.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/21.
//

import Foundation

class PriceFormatter {
    static func formatPrice(_ itemPrice: String) -> String {
        guard let priceNumber = Double(itemPrice) else { return itemPrice }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "JPY"
        
        if let formattedPrice = numberFormatter.string(from: NSNumber(value: priceNumber)) {
            return formattedPrice
        } else {
            return ""
        }
    }
}

