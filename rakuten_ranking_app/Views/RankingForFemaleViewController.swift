//
//  RankingForFemaleView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/09.
//

import UIKit

class RankingForFemaleViewController: UIViewController {
    
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
                            object: nil, queue: nil) { notification in
                               if let ranking = notification.userInfo?[NotificationConst.rankingNotificationName] as? Ranking {
                                   ranking.printData()
                               }
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = RankingModel(sex: .female, apiClient: DefaultAPIClient.shared)
        model.requestRanking()
    }
}
