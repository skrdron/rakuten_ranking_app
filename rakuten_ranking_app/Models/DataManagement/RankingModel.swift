//
//  RankingModel.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/13.
//

import Foundation

class RankingModel {
    let notificationCenter = NotificationCenter.default
    
    //取得したランキングデータを保持
    private(set) var ranking: Ranking! {
        didSet {
            //rankingプロパティが新しいデータで更新されると、通知を送信
            notificationCenter.post(
                name: .init(rawValue: NotificationConst.rankingNotificationName),
                object: nil,
                userInfo: [
                    NotificationConst.UserInfoKeysForRanking.ranking: ranking!,
                    NotificationConst.UserInfoKeysForRanking.sexType: sex
                ]
            )
        }
    }
    
    private let rankingAPI: RankingAPI
    
    //ランキングデータを取得する際のフィルター条件
    enum SexType {
        case all
        case male
        case female
   }
    

   let sex: SexType
    
   init(sex: SexType , apiClient: APIClient) {
      self.rankingAPI = .init(apiClient: apiClient)
      self.sex = sex
   }

   //指定された性別フィルターに基づいてランキングデータを取得
   func requestRanking() {
       rankingAPI.requestRanking(sex: sex) { [weak self] result in
          DispatchQueue.main.async {
             if case .success(let ranking) = result {
                self?.ranking = ranking
             }
          }
       }
    }
}
