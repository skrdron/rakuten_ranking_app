//
//  RankingModel.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/13.
//

import Foundation

final class RankingModel {
    public let notificationCenter = NotificationCenter.default
    public private(set) var ranking: Ranking! {
        didSet {
            notificationCenter.post(name: .init(rawValue: "ranking"),
                                    object: nil,
                                    userInfo: ["ranking": ranking!])
        }
    }
    private let rankingAPI: RankingAPI
    private let itemCode: String

    public init(itemCode: String, apiClient: APIClient) {
        self.itemCode = itemCode
        self.rankingAPI = .init(apiClient: apiClient)
    }

    public func requestRanking(_ completion: @escaping (Result<Ranking, APIError>) -> Void) {
        rankingAPI.requestRanking(itemCode: itemCode) { [weak self] result in
            DispatchQueue.main.async {
                if case .success(let ranking) = result {
                    self?.ranking = ranking
                }
                completion(result)
            }
        }
    }
}
