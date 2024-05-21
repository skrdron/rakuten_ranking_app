//
//  RankingAllView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/09.
//

import UIKit

class RankingForAllViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: RankingModel! {
      didSet {
        registerModel()
      }
    }
    
    private var items: [ItemElement] = []
    
    deinit {
      model.notificationCenter.removeObserver(self)
    }

    private func registerModel() {
      _ = model.notificationCenter
            .addObserver(forName: .init(rawValue: NotificationConst.rankingNotificationName),
                            object: nil, queue: nil) { notification in
                guard let sexType = notification.userInfo?["sexType"] as? RankingModel.SexType,
                    sexType == .all,
                    let ranking = notification.userInfo?[NotificationConst.rankingNotificationName] as? Ranking else {
                  return
                }
                self.items = ranking.items
                self.tableView.reloadData()
              }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        model = RankingModel(sex: .all, apiClient: DefaultAPIClient.shared)
        model.requestRanking()
    }
    
}


extension RankingForAllViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingForAllCell", for: indexPath) as! RankingTableViewCell
        let item = items[indexPath.row].item
        
        cell.rankingLabel.text = "\(item.rank)"
        cell.productNameLabel.text = item.itemName
        cell.priceLabel.text = PriceFormatter.formatPrice(item.itemPrice)
        cell.productImageView.image = nil
             
        if let urlString = item.mediumImageUrls.first?.imageURL {
            ImageFetcher.fetchImage(for: cell, at: indexPath, from: urlString, in: tableView)
        }
        
        return cell
    }
}

extension RankingForAllViewController: UITableViewDelegate {}
