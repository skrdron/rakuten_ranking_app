//
//  RankingForMaleView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/09.
//

import UIKit

class RankingForMaleViewController: UIViewController {
    var model: RankingModel! {
      didSet {
        registerModel()
      }
    }
    
    deinit {
      model.notificationCenter.removeObserver(self)
    }
    
    private func registerModel() {
      _ = model.notificationCenter
            .addObserver(forName: .init(rawValue: NotificationConst.rankingNotificationName),
                            object: nil, queue: nil) { [weak self] notification in
                               if let ranking = notification.userInfo?[NotificationConst.rankingNotificationName] as? Ranking {
                                   self?.printData(ranking: ranking)
                               }
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model = RankingModel(sex: 1, apiClient: DefaultAPIClient.shared)
        model.requestRanking()
    }
    
    private func printData(ranking: Ranking) {
        for itemElement in ranking.items {
              let item = itemElement.item
              print("商品名: \(item.itemName)")
          }
    }
}
