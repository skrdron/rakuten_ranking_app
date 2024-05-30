//
//  Search.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/24.
//

import Foundation

struct Search: Codable {
    let genreInformation: [GenreInformation]
    let items: [SearchItemElement]
    
    enum CodingKeys: String, CodingKey {
        case genreInformation = "GenreInformation"
        case items = "Items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genreInformation = try container.decode([GenreInformation].self, forKey: .genreInformation)
        items = try container.decode([SearchItemElement].self, forKey: .items)
    }
}

struct SearchItemElement: Codable {
    let item: SearchItem
    
    enum CodingKeys: String, CodingKey {
        case item = "Item"
    }
}

struct SearchItem: Codable {
    let affiliateRate: Int
    let affiliateUrl: String
    let asurakuArea: String
    let asurakuClosingTime: String
    let asurakuFlag: Int
    let availability: Int
    let catchcopy: String
    let creditCardFlag: Int
    let endTime: String
    let genreId: String
    let giftFlag: Int
    let imageFlag: Int
    let itemCaption: String
    let itemCode: String
    let itemName: String
    let itemPrice: Int
    let itemPriceBaseField: String
    let itemPriceMax1: Int
    let itemPriceMax2: Int
    let itemPriceMax3: Int
    let itemPriceMin1: Int
    let itemPriceMin2: Int
    let itemPriceMin3: Int
    let itemUrl: String
    let mediumImageUrls: [SearchImageUrl]
    let pointRate: Int
    let pointRateEndTime: String
    let pointRateStartTime: String
    let postageFlag: Int
    let reviewAverage: Float
    let reviewCount: Int
    let shipOverseasArea: String
    let shipOverseasFlag: Int
    let shopAffiliateUrl: String
    let shopCode: String
    let shopName: String
    let shopOfTheYearFlag: Int
    let shopUrl: String
    let smallImageUrls: [SearchImageUrl]
    let startTime: String
    let tagIds: [Int]
    let taxFlag: Int
}

struct SearchImageUrl: Codable {
    let imageUrl: String
}

struct GenreInformation: Codable {
}
