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
                               if let ranking = notification.userInfo?[NotificationConst.rankingNotificationName] as? Ranking {
                                   ranking.printData()
                                   self.items = ranking.items
                                   self.tableView.reloadData()
                               }
      }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        model = RankingModel(sex: .all, apiClient: DefaultAPIClient.shared)
        model.requestRanking()
    }
}


extension RankingForAllViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingCell", for: indexPath) as! RankingTableViewCell
        let item = items[indexPath.row].item
        tableView.rowHeight = 110
        
        cell.rankingLabel.text = "\(item.rank)"
        cell.productNameLabel.text = item.itemName
        cell.priceLabel.text = "¥\(item.itemPrice)"
        
        if let urlString = item.mediumImageUrls.first?.imageURL, let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.productImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        return cell
    }
}

extension RankingForAllViewController: UITableViewDelegate {

}
