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
    
    enum SexType: Int {
            case all = 0
            case male = 1
            case female = 2
            
            init(value: Int?) {
                switch value {
                case 1:
                    self = .male
                case 2:
                    self = .female
                default:
                    self = .all
                }
            }
            
            var description: String {
                switch self {
                case .all:
                    return "総合ランキング"
                case .male:
                    return "男性ランキング"
                case .female:
                    return "女性ランキング"
                }
            }
        }

    let sex: SexType
    
    public init(sex: Int? = nil, apiClient: APIClient) {
           self.rankingAPI = .init(apiClient: apiClient)
           self.sex = SexType(value: sex)
           print("現在取得しているランキング: \(self.sex.description)")
       }
    
       public func requestRanking() {
           let sexValue = sex.rawValue == 0 ? "" : "\(sex.rawValue)"
           rankingAPI.requestRanking(sex:sexValue) { [weak self] result in
               DispatchQueue.main.async {
                   if case .success(let ranking) = result {
                       self?.ranking = ranking
                   }
               }
           }
       }
}
