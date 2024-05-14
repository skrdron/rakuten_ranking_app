//
//  Ranking.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/13.
//

///データクラスの作成
import Foundation

public struct Ranking: Codable {
    public var items: [ItemElement]

    enum CodingKeys: String, CodingKey {
        case items = "Items"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decodeIfPresent([ItemElement].self, forKey: .items) ?? []
    }
}

public struct ItemElement: Codable {
    public let item: Item

    enum CodingKeys: String, CodingKey {
        case item = "Item"
    }
}

public struct Item: Codable {
    public let affiliateRate, affiliateURL, asurakuArea, asurakuClosingTime: String
    public let asurakuFlag, availability, carrier: Int
    public let catchcopy: String
    public let creditCardFlag: Int
    public let endTime, genreID: String
    public let hasPriceRange, imageFlag: Int
    public let itemCaption, itemCode, itemName, itemPrice: String
    public let itemPriceBaseField, itemPriceMax1, itemPriceMax2, itemPriceMax3: String
    public let itemPriceMin1, itemPriceMin2, itemPriceMin3: String
    public let itemURL: String
    public let mediumImageUrls: [ImageURL]
    public let pointRate: Int
    public let pointRateEndTime, pointRateStartTime: String
    public let postageFlag, rank: Int
    public let reviewAverage: String
    public let reviewCount: Int
    public let shipOverseasArea: String
    public let shipOverseasFlag: Int
    public let shopAffiliateURL, shopCode, shopName: String
    public let shopOfTheYearFlag: Int
    public let shopURL: String
    public let smallImageUrls: [ImageURL]
    public let startTime: String
    public let taxFlag: Int

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
    
    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
           affiliateRate = try container.decodeIfPresent(String.self, forKey: .affiliateRate) ?? ""
           affiliateURL = try container.decodeIfPresent(String.self, forKey: .affiliateURL) ?? ""
           asurakuArea = try container.decodeIfPresent(String.self, forKey: .asurakuArea) ?? ""
           asurakuClosingTime = try container.decodeIfPresent(String.self, forKey: .asurakuClosingTime) ?? ""
           asurakuFlag = try container.decodeIfPresent(Int.self, forKey: .asurakuFlag) ?? 0
           availability = try container.decodeIfPresent(Int.self, forKey: .availability) ?? 0
           carrier = try container.decodeIfPresent(Int.self, forKey: .carrier) ?? 0
           catchcopy = try container.decodeIfPresent(String.self, forKey: .catchcopy) ?? ""
           creditCardFlag = try container.decodeIfPresent(Int.self, forKey: .creditCardFlag) ?? 0
           endTime = try container.decodeIfPresent(String.self, forKey: .endTime) ?? ""
           genreID = try container.decodeIfPresent(String.self, forKey: .genreID) ?? ""
           hasPriceRange = try container.decodeIfPresent(Int.self, forKey: .hasPriceRange) ?? 0
           imageFlag = try container.decodeIfPresent(Int.self, forKey: .imageFlag) ?? 0
           itemCaption = try container.decodeIfPresent(String.self, forKey: .itemCaption) ?? ""
           itemCode = try container.decodeIfPresent(String.self, forKey: .itemCode) ?? ""
           itemName = try container.decodeIfPresent(String.self, forKey: .itemName) ?? ""
           itemPrice = try container.decodeIfPresent(String.self, forKey: .itemPrice) ?? ""
           itemPriceBaseField = try container.decodeIfPresent(String.self, forKey: .itemPriceBaseField) ?? ""
           itemPriceMax1 = try container.decodeIfPresent(String.self, forKey: .itemPriceMax1) ?? ""
           itemPriceMax2 = try container.decodeIfPresent(String.self, forKey: .itemPriceMax2) ?? ""
           itemPriceMax3 = try container.decodeIfPresent(String.self, forKey: .itemPriceMax3) ?? ""
           itemPriceMin1 = try container.decodeIfPresent(String.self, forKey: .itemPriceMin1) ?? ""
           itemPriceMin2 = try container.decodeIfPresent(String.self, forKey: .itemPriceMin2) ?? ""
           itemPriceMin3 = try container.decodeIfPresent(String.self, forKey: .itemPriceMin3) ?? ""
           itemURL = try container.decodeIfPresent(String.self, forKey: .itemURL) ?? ""
           mediumImageUrls = try container.decodeIfPresent([ImageURL].self, forKey: .mediumImageUrls) ?? []
           pointRate = try container.decodeIfPresent(Int.self, forKey: .pointRate) ?? 0
           pointRateEndTime = try container.decodeIfPresent(String.self, forKey: .pointRateEndTime) ?? ""
           pointRateStartTime = try container.decodeIfPresent(String.self, forKey: .pointRateStartTime) ?? ""
           postageFlag = try container.decodeIfPresent(Int.self, forKey: .postageFlag) ?? 0
           rank = try container.decodeIfPresent(Int.self, forKey: .rank) ?? 0
           reviewAverage = try container.decodeIfPresent(String.self, forKey: .reviewAverage) ?? ""
           reviewCount = try container.decodeIfPresent(Int.self, forKey: .reviewCount) ?? 0
           shipOverseasArea = try container.decodeIfPresent(String.self, forKey: .shipOverseasArea) ?? ""
           shipOverseasFlag = try container.decodeIfPresent(Int.self, forKey: .shipOverseasFlag) ?? 0
           shopAffiliateURL = try container.decodeIfPresent(String.self, forKey: .shopAffiliateURL) ?? ""
           shopCode = try container.decodeIfPresent(String.self, forKey: .shopCode) ?? ""
           shopName = try container.decodeIfPresent(String.self, forKey: .shopName) ?? ""
           shopOfTheYearFlag = try container.decodeIfPresent(Int.self, forKey: .shopOfTheYearFlag) ?? 0
           shopURL = try container.decodeIfPresent(String.self, forKey: .shopURL) ?? ""
           smallImageUrls = try container.decodeIfPresent([ImageURL].self, forKey: .smallImageUrls) ?? []
           startTime = try container.decodeIfPresent(String.self, forKey: .startTime) ?? ""
           taxFlag = try container.decodeIfPresent(Int.self, forKey: .taxFlag) ?? 0
    }
}

public struct ImageURL: Codable {
    public let imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
    }
}
