//
//  RankingAllView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/09.
//

import UIKit
import Models

final class RankingForAllViewController: UIViewController {
    
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
               .addObserver(forName: .init(rawValue: "ranking"),
                            object: nil, queue: nil) { [weak self] notification in
                               if let ranking = notification.userInfo?["ranking"] as? Ranking {
                                   self?.printData(ranking: ranking)
                               }
      }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let ranking = model?.ranking else {
              print("Error: model or model.ranking is nil")
              return
          }
        printData(ranking: ranking)
    }
    
    private func printData(ranking: Ranking) {
        for itemElement in ranking.items {
              let item = itemElement.item
              print("商品名: \(item.itemName)")
          }
    }
}
