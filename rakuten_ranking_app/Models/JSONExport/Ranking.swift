//
//  Ranking.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/13.
//

///データクラスの作成
import Foundation

struct Ranking: Codable {
    let items: [ItemElement]

    enum CodingKeys: String, CodingKey {
        case items = "Items"
    }
}

struct ItemElement: Codable {
    let item: Item

    enum CodingKeys: String, CodingKey {
        case item = "Item"
    }
}

struct Item: Codable {
    let affiliateRate, affiliateURL, asurakuArea, asurakuClosingTime: String
    let asurakuFlag, availability, carrier: Int
    let catchcopy: String
    let creditCardFlag: Int
    let endTime, genreID: String
    let hasPriceRange, imageFlag: Int
    let itemCaption, itemCode, itemName, itemPrice: String
    let itemPriceBaseField, itemPriceMax1, itemPriceMax2, itemPriceMax3: String
    let itemPriceMin1, itemPriceMin2, itemPriceMin3: String
    let itemURL: String
    let mediumImageUrls: [ImageURL]
    let pointRate: Int
    let pointRateEndTime, pointRateStartTime: String
    let postageFlag, rank: Int
    let reviewAverage: String
    let reviewCount: Int
    let shipOverseasArea: String
    let shipOverseasFlag: Int
    let shopAffiliateURL, shopCode, shopName: String
    let shopOfTheYearFlag: Int
    let shopURL: String
    let smallImageUrls: [ImageURL]
    let startTime: String
    let taxFlag: Int

    enum CodingKeys: String, CodingKey {
        case affiliateRate
        case affiliateURL = "affiliateUrl"
        case asurakuArea, asurakuClosingTime, asurakuFlag, availability, carrier, catchcopy, creditCardFlag, endTime
        case genreID = "genreId"
        case hasPriceRange, imageFlag, itemCaption, itemCode, itemName, itemPrice, itemPriceBaseField, itemPriceMax1, itemPriceMax2, itemPriceMax3, itemPriceMin1, itemPriceMin2, itemPriceMin3
        case itemURL = "itemUrl"
        case mediumImageUrls, pointRate, pointRateEndTime, pointRateStartTime, postageFlag, rank, reviewAverage, reviewCount, shipOverseasArea, shipOverseasFlag
        case shopAffiliateURL = "shopAffiliateUrl"
        case shopCode, shopName, shopOfTheYearFlag
        case shopURL = "shopUrl"
        case smallImageUrls, startTime, taxFlag
    }
}

struct ImageURL: Codable {
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
    }
}

